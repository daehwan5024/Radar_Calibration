[num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(10, 4, 4);
distMeasured(3, 5) = NaN;
distMeasured(5, 3) = NaN;
distMeasured(4, 7) = NaN;
distMeasured(7, 4) = NaN;

save test.mat
tic
posCalibrated = getCalibrateTriangleSize(distMeasured, num_radar+num_bottom);
toc
meanError = getDifference(posAbsolute, posCalibrated);

