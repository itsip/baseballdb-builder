import os
import urllib.request
import zipfile
import subprocess
import database
import datafix

PROJECT_ROOT = database.PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
VERSION = 'v2022.2'

# Prompt for database credentials
print('This utility will create a new PostgreSQL database populated with baseball data.\n')
db_name = input('new database name: (baseball) ')
host = input('host: (localhost) ')
port = input('port: (5432) ')
password = input('password: () ')

database.setup(db_name, host, port, password)

# Download baseball data
print('Downloading baseball data...')
url = 'https://github.com/chadwickbureau/baseballdatabank/archive/refs/tags/%s.zip' % (VERSION)
download_dir = '%s/download' % (PROJECT_ROOT)
subprocess.run(['mkdir', download_dir])
filename = '%s/%s.zip' % (download_dir, VERSION)
urllib.request.urlretrieve(url, filename)

# Extract zip containing baseball data
print('Extracting baseball data...')
data_dir = '%s/data' % (PROJECT_ROOT)
subprocess.run(['mkdir', data_dir])

with zipfile.ZipFile(filename) as archive:
    archive.extractall(data_dir)

database.DIR = datafix.DIR = '%s/baseballdatabank-%s' % (data_dir, VERSION[1:])

# Remove bad CSV data
datafix.remove_bad_data()

# Create database
print('Creating database named "%s"...' % database.db_name)
subprocess.run(['createdb', database.db_name])

# Create schema
print('Creating schema for "%s"...' % database.db_name)
database.create_schema()

# Copy data to database
print('Copying data to "%s"...' % database.db_name)
database.copy_data()

# Make corrections to data in db
query = datafix.get_corrections()
database.query(query)

# Update related tables to use new primary keys for relationships
print('Updating relationships...')
database.update_relationships()

# Add foreign keys
print('Adding foreign keys...')
database.add_foreign_keys()

# Remove temp directories
print('Cleaning up...')
subprocess.run(['rm', '-r', data_dir])
subprocess.run(['rm', '-r', download_dir])

# Restore environment variables
database.cleanup()

print('Success')
