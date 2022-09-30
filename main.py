import os
import urllib.request

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))

default_version = 'v2022.2'

url = "https://github.com/chadwickbureau/baseballdatabank/archive/refs/tags/%s.zip" % (default_version)
filename = "%s/downloads/%s.zip" % (PROJECT_ROOT, default_version)

urllib.request.urlretrieve(url, filename)
