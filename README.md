# BaseballDB Builder
Python tool for building the [Baseball Databank](https://github.com/chadwickbureau/baseballdatabank)
as a Postgresql database.

## Usage
`python build.py`

## Notes
Certain rows from the sourced data are excluded from the created Postgresql database in order to successfully add foreign keys.

See [datafix.py](datafix.py) for more details.

## License
BaseballDB Builder is licensed under the [GNU General Public License v3.0](LICENSE)

[Baseball Databank](https://github.com/chadwickbureau/baseballdatabank) is licensed by
[Chadwick Baseball Bureau](https://www.chadwick-bureau.com) under the
[Creative Commons Attribution-ShareAlike 3.0 Unported License](https://creativecommons.org/licenses/by-sa/3.0/)
