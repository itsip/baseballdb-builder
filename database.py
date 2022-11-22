import os
import re
import subprocess

db_name = "baseball"
host = "localhost"
port = "5432"
old_password = None
command = ["psql", "-h", host, "-p", port, "-d", db_name]
DIR = None
PROJECT_ROOT = None
CORE_TABLES = [
    "People",
    "Teams_Franchises",
    "Teams",
    "Parks",
    "Managers",
    "Fielding",
    "Pitching_Post",
    "Appearances",
    "Batting",
    "Managers_Half",
    "Fielding_OF",
    "Pitching",
    "Home_Games",
    "Batting_Post",
    "Teams_Half",
    "Series_Post",
    "Fielding_Post",
    "Allstar_Full",
    "Fielding_OF_split",
]
CONTRIB_TABLES = [
    "Awards_Managers",
    "Awards_Players",
    "Awards_Share_Managers",
    "Awards_Share_Players",
    "College_Playing",
    "Hall_Of_Fame",
    "Salaries",
    "Schools",
]


def setup(name, hst, prt, pswd):
    global db_name, host, port, password
    db_name = name if name != "" else db_name
    host = hst if hst != "" else host
    port = prt if prt != "" else port
    password = pswd if pswd != "" else ""

    if "PGPASSWORD" in os.environ:
        global old_password
        old_password = os.environ["PGPASSWORD"]

    if password != "":
        os.environ["PGPASSWORD"] = password


def cleanup():
    if "PGPASSWORD" in os.environ:
        del os.environ["PGPASSWORD"]
    if old_password:
        os.environ["PGPASSWORD"] = old_password


def query(query, return_output=False):
    if return_output:
        return subprocess.run(
            command + ["-t", "-c", query], capture_output=True, text=True
        )

    return subprocess.run(command + ["-c", query], stdout=subprocess.DEVNULL)


def query_with_file(file):
    subprocess.run(command + ["-f", file], stdout=subprocess.DEVNULL)


def get_columns(table):
    select = """SELECT column_name FROM information_schema.columns
                where table_catalog = \'{0}\' and table_name = \'{1}\'
                and column_name != \'id\' order by ordinal_position;""".format(
        db_name, table
    )
    column_names = query(select, return_output=True)
    return (
        "("
        + ",".join(f'"{column_name}"' for column_name in column_names.stdout.split())
        + ")"
    )


def get_tables_with(column, excluded_table=None):
    select = (
        "select table_name from information_schema.columns where column_name = '%s';"
        % (column)
    )
    if excluded_table:
        select = select[:-1] + " and table_name != '%s';" % (excluded_table)
    table_names = query(select, return_output=True)
    return table_names.stdout.split()


def get_copy_commands(tables, dir):
    eol_pattern = re.compile(r"$")
    underscore_pattern = re.compile(r"\_")
    copy_commands = ""
    for table in tables:
        filename = (
            dir + "/" + eol_pattern.sub(r".csv", underscore_pattern.sub(r"", table))
        )
        table = table.lower()
        copy_query = "COPY %s %s FROM '%s' WITH DELIMITER ',' CSV HEADER;\n"
        columns = get_columns(table)
        copy_commands += copy_query % (table, columns, filename)
    return copy_commands


def create_schema():
    schema_filename = "%s/db/schema.sql" % (PROJECT_ROOT)
    query_with_file(schema_filename)


def copy_data():
    query(get_copy_commands(CORE_TABLES, "%s/core" % (DIR)))
    query(get_copy_commands(CONTRIB_TABLES, "%s/contrib" % (DIR)))


def update_relationships():
    player_tables = get_tables_with("player_id", excluded_table="people")
    team_tables = get_tables_with("team_id", excluded_table="teams")

    update_query = """UPDATE {0} SET player_id = people.id FROM people WHERE people.player_id = {0}.player_id;
                      ALTER TABLE {0} ALTER COLUMN player_id TYPE integer USING player_id::integer;"""

    for table in player_tables:
        query(update_query.format(table))

    update_query = """UPDATE {0} SET team_id = teams.id FROM teams WHERE teams.team_id = {0}.team_id AND teams.year_id = {0}.year_id;
                      ALTER TABLE {0} ALTER COLUMN team_id TYPE integer USING team_id::integer;"""

    for table in team_tables:
        query(update_query.format(table))

    update_query = """UPDATE home_games SET park_id = parks.id FROM parks WHERE parks.park_id = home_games.park_id;
                      ALTER TABLE home_games ALTER COLUMN park_id TYPE integer USING park_id::integer;

                      UPDATE college_playing SET school_id = schools.id FROM schools WHERE schools.school_id = college_playing.school_id;
                      ALTER TABLE college_playing ALTER COLUMN school_id TYPE integer USING school_id::integer;

                      UPDATE teams SET franch_id = teams_franchises.id FROM teams_franchises WHERE teams_franchises.franch_id = teams.franch_id;
                      ALTER TABLE teams ALTER COLUMN franch_id TYPE integer USING franch_id::integer;

                      UPDATE series_post SET team_id_winner = teams.id FROM teams WHERE series_post.team_id_winner = teams.team_id;
                      ALTER TABLE series_post ALTER COLUMN team_id_winner TYPE integer USING team_id_winner::integer;

                      UPDATE series_post SET team_id_loser = teams.id FROM teams WHERE series_post.team_id_loser = teams.team_id;
                      ALTER TABLE series_post ALTER COLUMN team_id_loser TYPE integer USING team_id_loser::integer;"""

    query(update_query)


def add_foreign_keys():
    constraints_filename = "%s/db/constraints.sql" % (PROJECT_ROOT)
    query_with_file(constraints_filename)
