import os
import urllib.request
import zipfile
import subprocess
import re
import datafix

# Database creds
DB_NAME = input('database name: (baseball) ')
HOST = input('host: (localhost) ')
PORT = input('port: (5432) ')
PASSWORD = input('password: () ')

DB_NAME = 'baseball' if DB_NAME == '' else DB_NAME
HOST = 'localhost' if HOST == '' else HOST
PORT = '5432' if PORT == '' else PORT

OLD_PASSWORD = None
if 'PGPASSWORD' in os.environ:
    OLD_PASSWORD = os.environ['PGPASSWORD']

if PASSWORD != '':
    os.environ['PGPASSWORD'] = PASSWORD

def get_columns(table):
    select = '''SELECT column_name FROM information_schema.columns
                where table_catalog = \'{0}\' and table_name = \'{1}\'
                and column_name != \'id\' order by ordinal_position;'''.format(DB_NAME, table)
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
datafix.remove_bad_data(baseball_data_dir)

print('Creating database named "%s"...' % DB_NAME)

# Create database
subprocess.run(['createdb', DB_NAME])

print('Creating schema for "%s"...' % DB_NAME)
schema_filename = '%s/db/schema.sql' % (PROJECT_ROOT)

# Create schema
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-f', schema_filename], stdout=subprocess.DEVNULL)

core_tables = [ 'People', 'Teams_Franchises', 'Teams', 'Parks', 'Managers', 'Fielding',
               'Pitching_Post', 'Appearances', 'Batting', 'Managers_Half', 'Fielding_OF',
               'Pitching', 'Home_Games', 'Batting_Post', 'Teams_Half', 'Series_Post',
               'Fielding_Post', 'Allstar_Full', 'Fielding_OF_split' ]

copy_commands = get_copy_commands(core_tables, core_data_dir)

print('Copying core data to "%s"...' % DB_NAME)

# Copy core data
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', copy_commands], stdout=subprocess.DEVNULL)

contrib_tables = [ 'Awards_Managers', 'Awards_Players', 'Awards_Share_Managers',
                  'Awards_Share_Players', 'College_Playing', 'Hall_Of_Fame',
                  'Salaries', 'Schools' ]

copy_commands = get_copy_commands(contrib_tables, contrib_data_dir)

print('Copying contrib data to "%s"...' % DB_NAME)

# Copy contrib data
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', copy_commands], stdout=subprocess.DEVNULL)

# Update related tables to use new primary keys in relation
player_tables = get_tables_with('player_id', excluded_table='people')
team_tables = get_tables_with('team_id', excluded_table='teams')

print('Updating table relations...')

update_query = '''UPDATE {0} SET player_id = people.id FROM people WHERE people.player_id = {0}.player_id;
                  ALTER TABLE {0} ALTER COLUMN player_id TYPE integer USING player_id::integer;'''

for table in player_tables:
    subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', update_query.format(table)], stdout=subprocess.DEVNULL)

update_query = '''UPDATE {0} SET team_id = teams.id FROM teams WHERE teams.team_id = {0}.team_id AND teams.year_id = {0}.year_id;
                  ALTER TABLE {0} ALTER COLUMN team_id TYPE integer USING team_id::integer;'''

for table in team_tables:
    subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', update_query.format(table)], stdout=subprocess.DEVNULL)

update_query = '''UPDATE home_games SET park_id = parks.id FROM parks WHERE parks.park_id = home_games.park_id;
                  ALTER TABLE home_games ALTER COLUMN park_id TYPE integer USING park_id::integer;

                  UPDATE college_playing SET school_id = schools.id FROM schools WHERE schools.school_id = college_playing.school_id;
                  ALTER TABLE college_playing ALTER COLUMN school_id TYPE integer USING school_id::integer;

                  UPDATE teams SET franch_id = teams_franchises.id FROM teams_franchises WHERE teams_franchises.franch_id = teams.franch_id;
                  ALTER TABLE teams ALTER COLUMN franch_id TYPE integer USING franch_id::integer;

                  UPDATE series_post SET team_id_winner = teams.id FROM teams WHERE series_post.team_id_winner = teams.team_id;
                  ALTER TABLE series_post ALTER COLUMN team_id_winner TYPE integer USING team_id_winner::integer;

                  UPDATE series_post SET team_id_loser = teams.id FROM teams WHERE series_post.team_id_loser = teams.team_id;
                  ALTER TABLE series_post ALTER COLUMN team_id_loser TYPE integer USING team_id_loser::integer;'''

subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-c', update_query], stdout=subprocess.DEVNULL)

print('Adding foreign keys...')
constraints_filename = '%s/db/constraints.sql' % (PROJECT_ROOT)
subprocess.run(['psql', '-h', HOST, '-p', PORT, '-d', DB_NAME, '-f', constraints_filename], stdout=subprocess.DEVNULL)

print('Cleaning up...')

# Remove temp directories
subprocess.run(['rm', '-r', data_dir])
subprocess.run(['rm', '-r', download_dir])

# Restore environment variables
if 'PGPASSWORD' in os.environ:
    del os.environ['PGPASSWORD']
if OLD_PASSWORD:
    os.environ['PGPASSWORD'] = OLD_PASSWORD

print('Success')
