# BaseballDB Builder
Python utility for building the [Baseball Databank](https://github.com/chadwickbureau/baseballdatabank)
as a PostgreSQL database.

## Requiremenets
[Python 3.7+](https://www.python.org/downloads)

[PostgreSQL 10+](https://www.postgresql.org/download)

## Usage
To create a PostgreSQL database populated with data from the [Baseball Databank](https://github.com/chadwickbureau/baseballdatabank),
run:

`python build.py`

## Notes
Certain rows from the sourced data are excluded from the created PostgreSQL database in order to successfully add foreign keys.

See [datafix.py](datafix.py) for more details.

## License
BaseballDB Builder is licensed under the [GNU General Public License v3.0](LICENSE)

[Baseball Databank](https://github.com/chadwickbureau/baseballdatabank) is licensed by
[Chadwick Baseball Bureau](https://www.chadwick-bureau.com) under the
[Creative Commons Attribution-ShareAlike 3.0 Unported License](https://creativecommons.org/licenses/by-sa/3.0/)
