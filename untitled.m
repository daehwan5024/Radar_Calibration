% [num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(6, 3, 4);
distMeasured = getNoiseAdded2(distAbsolute, num_bottom);

posCalibrated = getCalibratePDOP(distMeasured, num_radar+num_bottom);

meanError = getDifference(posAbsolute, posCalibrated);