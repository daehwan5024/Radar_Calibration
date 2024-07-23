from scipy.io import loadmat
import os
import matplotlib.pyplot as plt
directory = os.fsencode("StoredData/2_4_1")
err_list = []
PDOP_list = []
for file in os.listdir(directory):
    filename = os.fsdecode(file)
    filename = "StoredData/2_4_1/" + filename
    matrixVar = loadmat(filename)
    print(matrixVar)