[num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(6, 3, 4);
tic
posCalibrated = getCalibrateTriangleSize(distMeasured, num_radar+num_bottom);
toc
meanError = getDifference(posAbsolute, posCalibrated);
