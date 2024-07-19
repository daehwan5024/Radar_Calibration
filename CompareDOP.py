from scipy.io import loadmat

import numpy
import os

new_rse = 0
old_rse = 0

for root, dirs, files in os.walk("./StoredData/Dataset_New", topdown=False):
    for name in files:
        filepath = os.path.join(root, name)
        if not(filepath.endswith(".mat")):
            continue
        data = loadmat(filepath)
        if type(data['rse'][0][0]) == numpy.complex128:
            print(name)
            continue
        new_rse += data['rse'][0][0]
print(new_rse)

for root, dirs, files in os.walk("./StoredData/Dataset_Old", topdown=False):
    for name in files:
        filepath = os.path.join(root, name)
        if not(filepath.endswith(".mat")):
            continue
        data = loadmat(filepath)
        if type(data['rse'][0][0]) == numpy.complex128:
            print(name)
            continue
        old_rse += data['rse'][0][0]
print(old_rse)