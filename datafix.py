files = [ { 'filename': 'core/Appearances.csv', 'lines': [718] },
          { 'filename': 'core/FieldingOF.csv', 'lines': [462] },
          { 'filename': 'core/HomeGames.csv', 'lines': [3156, 3191] },
          { 'filename': 'core/AllstarFull.csv', 'lines': [69] },
          { 'filename': 'contrib/CollegePlaying.csv', 'lines': [5172, 5173, 5174, 5468, 10709, 13769, 13770, 13771, 17075, 17076] } ]

def remove_lines(filename, lines):
    with open(filename, 'r') as file:
        lines = file.readlines()
    with open(filename, 'w') as file:
        i = 1
        for line in lines:
            if i not in lines:
                file.write(line)
                i += 1

def remove_bad_data(dir):
    for file in files:
        remove_lines('%s/%s' % (dir, file['filename']), file['lines'])
