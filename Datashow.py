from scipy.io import loadmat
import os
import matplotlib.pyplot as plt
directory = os.fsencode("StoredData/DOP_ERR_Relation")
err_list = []
PDOP_list = []
for file in os.listdir(directory):
    filename = os.fsdecode(file)
    filename = "StoredData/DOP_ERR_Relation/" + filename
    matrixVar = loadmat(filename)

    err_list.append(matrixVar['total_err'][0][0])
    PDOP_list.append(matrixVar['ordersABS'][0][0])
for i in range(len(err_list)):
    print(err_list[i])
    print(PDOP_list[i])
    print()
plt.plot(PDOP_list, err_list, "r.")
plt.show()