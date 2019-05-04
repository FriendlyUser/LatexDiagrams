import os
import subprocess

path = os.path.dirname(os.path.realpath(__file__))

files = []
# r=root, d=directories, f = files
for r, d, f in os.walk(path):
    for file in f:
        if '.tex' in file:
            files.append(os.path.join(r, file))

for f in files:
    print(f)
    diagram_created = subprocess.call(['lualatex', f], shell=False) # shell should be set to False
    if diagram_created == 0:
        print('Successfully created Document')
    else:
        print('Failed To Create File, exiting')
        exit()