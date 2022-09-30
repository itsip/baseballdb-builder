import os
import urllib.request
import zipfile
from tqdm import tqdm

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))

# Progress Bar
class TqdmUpTo(tqdm):
    def update_to(self, b=1, bsize=1, tsize=None):
        if tsize is not None:
            self.total = tsize
        return self.update(b * bsize - self.n)  # also sets self.n = b * bsize

default_version = 'v2022.2'

url = "https://github.com/chadwickbureau/baseballdatabank/archive/refs/tags/%s.zip" % (default_version)
filename = "%s/download/%s.zip" % (PROJECT_ROOT, default_version)

print("Downloading baseball database...\n")

# Download baseball data w/ progress bar
with TqdmUpTo(unit = 'B', unit_scale=True, unit_divisor=1024, miniters=1) as t:
    urllib.request.urlretrieve(url, filename, t.update_to)

output_directory = "%s/data" % (PROJECT_ROOT)

print("\nExtracting baseball database...\n")

# Extract zip containing baseball data
with zipfile.ZipFile(filename) as archive:
    total_size = 0
    for info in archive.infolist():
        total_size += info.file_size

    with tqdm(total=total_size, unit = 'B', unit_scale=True, unit_divisor=1024) as pbar:
        for info in archive.infolist():
            archive.extract(info.filename, output_directory)
            pbar.update(info.file_size)
