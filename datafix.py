DIR = None
FILE_REMOVALS = [
    {"filename": "core/Appearances.csv", "lines": [718]},
    {"filename": "core/FieldingOF.csv", "lines": [462]},
    {"filename": "core/HomeGames.csv", "lines": [3156, 3158, 3168, 3191, 3193, 3194]},
    {
        "filename": "contrib/CollegePlaying.csv",
        "lines": [5172, 5173, 5174, 5468, 10709, 13769, 13770, 13771, 17075, 17076],
    },
]
DB_UPDATES = [
    {
        "table": "allstar_full",
        "column": "team_id",
        "old": "MLN",
        "new": "ML1",
        "cond": "",
    },
    {
        "table": "allstar_full",
        "column": "team_id",
        "old": "MIL",
        "new": "ML4",
        "cond": "AND (year_id BETWEEN 1970 AND 1997)",
    },
    {
        "table": "allstar_full",
        "column": "team_id",
        "old": "LAA",
        "new": "ANA",
        "cond": "AND (year_id BETWEEN 1997 AND 2004)",
    },
]


def remove_lines(filename, line_numbers):
    with open(filename, "r") as file:
        lines = file.readlines()
    with open(filename, "w") as file:
        for line_number, line in enumerate(lines, 1):
            if line_number not in line_numbers:
                file.write(line)


def remove_bad_data():
    for file in FILE_REMOVALS:
        remove_lines("%s/%s" % (DIR, file["filename"]), file["lines"])


def get_corrections():
    query = ""
    for update in DB_UPDATES:
        query += """UPDATE {0} SET {1} = \'{3}\'
                WHERE {1} = \'{2}\' {4};""".format(
            update["table"],
            update["column"],
            update["old"],
            update["new"],
            update["cond"],
        )

    return query
