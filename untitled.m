load StoredData\2_5_1\2024_07_23_10_55_58_357.mat
distAbsolute = getPairwiseDist(posAbsolute);
for i=1:5
    rmse(distAbsolute, distMeasured(:,:,i),  "all")
end