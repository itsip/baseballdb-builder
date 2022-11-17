import subprocess
import os

db_name = 'baseball'
host = 'localhost'
port = '5432'
password = ''
old_password = None
command = ['psql', '-h', host, '-p', port, '-d', db_name]

def setup_password():
    if 'PGPASSWORD' in os.environ:
        old_password = os.environ['PGPASSWORD']

    if password != '':
        os.environ['PGPASSWORD'] = password

def restore_password():
    if 'PGPASSWORD' in os.environ:
        del os.environ['PGPASSWORD']
    if old_password:
        os.environ['PGPASSWORD'] = old_password

def query(query, return_output=False):
    subprocess.run(command + ['-c', query], stdout=subprocess.DEVNULL, capture_output=return_output, text=return_output)

def query_with_file(file):
    subprocess.run(command + ['-f', file], stdout=subprocess.DEVNULL)
