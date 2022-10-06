import os
import urllib.request
import zipfile
import subprocess
import re

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))

version = 'v2022.2'

url = 'https://github.com/chadwickbureau/baseballdatabank/archive/refs/tags/%s.zip' % (version)
download_directory = '%s/download' % (PROJECT_ROOT)
subprocess.run(['mkdir', download_directory])
filename = '%s/%s.zip' % (download_directory, version)

print('Downloading baseball data...\n')

# Download baseball data
urllib.request.urlretrieve(url, filename)

output_directory = '%s/data' % (PROJECT_ROOT)
subprocess.run(['mkdir', output_directory])

print('\nExtracting baseball data...\n')

# Extract zip containing baseball data
with zipfile.ZipFile(filename) as archive:
    archive.extractall(output_directory)

db_name = 'baseball'
host = 'localhost'
port = '5432'
schema_filename = '%s/db/schema.sql' % (PROJECT_ROOT)

print('\n\nCreating database named "baseball"...\n')

# Create database
subprocess.run(['createdb', db_name])

print('\nCreating schema for "baseball"...\n')

# Create schema
subprocess.run(['psql', '-h', host, '-p', port, '-d', db_name, '-f', schema_filename], stdout=subprocess.DEVNULL)

core_data_dir = '%s/data/baseballdatabank-2022.2/core' % (PROJECT_ROOT)
contrib_data_dir = '%s/data/baseballdatabank-2022.2/contrib' % (PROJECT_ROOT)
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

print('\nCopying core data to "baseball"\n')

# Copy core data
subprocess.run(['psql', '-h', host, '-p', port, '-d', db_name, '-c', copy_commands])
