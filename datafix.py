DIR = None

FILES = [ { 'filename': 'core/Appearances.csv', 'lines': [718] },
          { 'filename': 'core/FieldingOF.csv', 'lines': [462] },
          { 'filename': 'core/HomeGames.csv', 'lines': [3156, 3158, 3168, 3191, 3193, 3194] },
          { 'filename': 'contrib/CollegePlaying.csv', 'lines': [5172, 5173, 5174, 5468, 10709, 13769, 13770, 13771, 17075, 17076] } ]

POST_DB_FIXES = [ {'table': 'allstar_full', 'column': 'team_id', 'old': 'MLN', 'new': 'ML1'} ]

def remove_lines(filename, line_numbers):
    with open(filename, 'r') as file:
        lines = file.readlines()
    with open(filename, 'w') as file:
        for line_number, line in enumerate(lines, 1):
            if line_number not in line_numbers:
                file.write(line)

def remove_bad_data():
    for file in FILES:
        remove_lines('%s/%s' % (dir, file['filename']), file['lines'])
