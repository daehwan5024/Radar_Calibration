[num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(6, 3, 4);

posCalibrated = getCalibratePDOP(distMeasured, num_radar+num_bottom);
posCalibrated2 = getCalibrateTriangleSize(distMeasured, num_radar+num_bottom);
meanError = getDifference(posAbsolute, posCalibrated);
meanError2 = getDifference(posAbsolute, posCalibrated2);