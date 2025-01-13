import os

packages = [
    "spoof",
    "npm-check-updates",
]

os.system("npm install -g %s" % " ".join(packages))
