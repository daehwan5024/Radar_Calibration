from scipy.io import savemat
from scipy.io import loadmat

import os

for root, dirs, files in os.walk("./StoredData/Old", topdown=False):
    for name in files:
        filepath = os.path.join(root, name)
        if not(filepath.endswith(".mat")):
            continue
        data = loadmat(filepath)
        data['rse'][0][0] = data['rse'][0][0] / 8
        savemat(filepath, data)