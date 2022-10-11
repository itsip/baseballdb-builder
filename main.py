import os
import urllib.request
import zipfile
import subprocess
import re

# Database creds
DB_NAME = 'baseball'
HOST = 'localhost'
PORT = '5432'

def remove_line(filename, line_number):
    with open(filename, 'r') as file:
        lines = file.readlines()
    with open(filename, 'w') as file:
        i = 1
        for line in lines:
            if i != line_number:
                file.write(line)
                i += 1

def get_columns(table):
    select = '''SELECT column_name FROM information_schema.columns
                where table_catalog = \'baseball\' and table_name = \'{0}\'
                and column_name != \'id\' order by ordinal_position;'''.format(table)
    column_names = subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-t', '-c', select], capture_output=True, text=True)
    return '(' + ','.join(f'"{column_name}"' for column_name in column_names.stdout.split()) + ')'

def get_copy_commands(tables, dir):
    eol_pattern = re.compile(r'$')
    underscore_pattern = re.compile(r'\_')
    copy_commands = ''
    for table in tables:
        filename = dir + '/' + eol_pattern.sub(r'.csv', underscore_pattern.sub(r'', table))
        table = table.lower()
        copy_query = 'COPY %s %s FROM \'%s\' WITH DELIMITER \',\' CSV HEADER;\n'
        columns = get_columns(table)
        copy_commands += copy_query % (table, columns, filename)
    return copy_commands

def get_tables_with(column, excluded_table = None):
    query = 'select table_name from information_schema.columns where column_name = \'%s\';' % (column)
    if excluded_table:
        query = query[:-1] + ' and table_name != \'%s\';' % (excluded_table)
    table_names = subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-t', '-c', query], capture_output=True, text=True)
    return table_names.stdout.split()

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))

version = 'v2022.2'

url = 'https://github.com/chadwickbureau/baseballdatabank/archive/refs/tags/%s.zip' % (version)
download_dir = '%s/download' % (PROJECT_ROOT)
subprocess.run(['mkdir', download_dir])
filename = '%s/%s.zip' % (download_dir, version)

print('Downloading baseball data...')

# Download baseball data
urllib.request.urlretrieve(url, filename)

data_dir = '%s/data' % (PROJECT_ROOT)
subprocess.run(['mkdir', data_dir])

print('Extracting baseball data...')

# Extract zip containing baseball data
with zipfile.ZipFile(filename) as archive:
    archive.extractall(data_dir)

baseball_data_dir = '%s/baseballdatabank-2022.2' % (data_dir)
core_data_dir = '%s/core' % (baseball_data_dir)
contrib_data_dir = '%s/contrib' % (baseball_data_dir)

# Correct data for integrity purposes
remove_line('%s/Appearances.csv' % (core_data_dir), 718)
remove_line('%s/FieldingOF.csv' % (core_data_dir), 462)
remove_line('%s/HomeGames.csv' % (core_data_dir), 3156)
remove_line('%s/HomeGames.csv' % (core_data_dir), 3191)
remove_line('%s/AllstarFull.csv' % (core_data_dir), 69)

print('Creating database named "baseball"...')

# Create database
subprocess.run(['createdb', DB_NAME])

print('Creating schema for "baseball"...')
schema_filename = '%s/db/schema.sql' % (PROJECT_ROOT)

# Create schema
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-f', schema_filename], stdout=subprocess.DEVNULL)

core_tables = [ 'People', 'Teams_Franchises', 'Teams', 'Parks', 'Managers', 'Fielding',
               'Pitching_Post', 'Appearances', 'Batting', 'Managers_Half', 'Fielding_OF',
               'Pitching', 'Home_Games', 'Batting_Post', 'Teams_Half', 'Series_Post',
               'Fielding_Post', 'Allstar_Full', 'Fielding_OF_split' ]

copy_commands = get_copy_commands(core_tables, core_data_dir)

print('Copying core data to "baseball"...')

# Copy core data
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', copy_commands], stdout=subprocess.DEVNULL)

contrib_tables = [ 'Awards_Managers', 'Awards_Players', 'Awards_Share_Managers',
                  'Awards_Share_Players', 'College_Playing', 'Hall_Of_Fame',
                  'Salaries', 'Schools' ]

copy_commands = get_copy_commands(contrib_tables, contrib_data_dir)

print('Copying contrib data to "baseball"...')

# Copy contrib data
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', copy_commands], stdout=subprocess.DEVNULL)

# Update related tables to use new primary keys in relation
player_tables = get_tables_with('player_id', excluded_table='people')
team_tables = get_tables_with('team_id', excluded_table='teams')

print('Updating table relations...')

update_query = 'UPDATE %s SET player_id = people.id FROM people WHERE people.player_id = %s.player_id;'
for table in player_tables:
    subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', update_query % (table, table)], stdout=subprocess.DEVNULL)

update_query = 'UPDATE %s SET team_id = teams.id FROM teams WHERE teams.team_id = %s.team_id AND teams.year_id = %s.year_id;'
for table in team_tables:
    subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', update_query % (table, table, table)], stdout=subprocess.DEVNULL)

update_query = '''UPDATE college_playing SET school_id = schools.id FROM schools WHERE schools.school_id = college_playing.school_id;
                  UPDATE teams SET franch_id = teams_franchises.id FROM teams_franchises WHERE teams_franchises.franch_id = teams.franch_id;
                  UPDATE series_post SET team_id_winner = teams.id FROM teams WHERE series_post.team_id_winner = teams.team_id;
                  UPDATE series_post SET team_id_loser = teams.id FROM teams WHERE series_post.team_id_loser = teams.team_id;'''
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', update_query], stdout=subprocess.DEVNULL)

# Remove temp directories
subprocess.run(['rm', '-r', data_dir])
subprocess.run(['rm', '-r', download_dir])

print('Success')
