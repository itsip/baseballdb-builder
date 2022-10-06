import os
import urllib.request
import zipfile
import subprocess
import re

def remove_line(filename, line_number):
    with open(filename, 'r') as file:
        lines = file.readlines()
    with open(filename, 'w') as file:
        i = 1
        for line in lines:
            if i != line_number:
                file.write(line)
                i += 1


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

# Database creds
db_name = 'baseball'
host = 'localhost'
port = '5432'
schema_filename = '%s/db/schema.sql' % (PROJECT_ROOT)

print('Creating database named "baseball"...')

# Create database
subprocess.run(['createdb', db_name])

print('Creating schema for "baseball"...')

# Create schema
subprocess.run(['psql', '-h', host, '-p', port, '-d', db_name, '-f', schema_filename], stdout=subprocess.DEVNULL)

copy_query = 'COPY %s FROM \'%s/%s\' WITH DELIMITER \',\' CSV HEADER;\n'
eol_pattern = re.compile(r'$')
underscore_pattern = re.compile(r'\_')
copy_commands = ''
core_tables = [ 'People', 'Teams_Franchises', 'Teams', 'Parks', 'Managers', 'Fielding', 'Pitching_Post', 'Appearances', 'Batting',
          'Managers_Half', 'Fielding_OF', 'Pitching', 'Home_Games', 'Batting_Post', 'Teams_Half', 'Series_Post', 'Fielding_Post',
          'Allstar_Full', 'Fielding_OF_split' ]

for table in core_tables:
    filename = eol_pattern.sub(r'.csv', underscore_pattern.sub(r'', table))
    copy_commands += copy_query % (table, core_data_dir, filename)

print('Copying core data to "baseball"...')

# Copy core data
subprocess.run(['psql', '-h', host, '-p', port, '-d', db_name, '-c', copy_commands], stdout=subprocess.DEVNULL)

# Remove temp directories
subprocess.run(['rm', '-r', data_dir])
subprocess.run(['rm', '-r', download_dir])
