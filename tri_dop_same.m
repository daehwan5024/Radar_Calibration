i = 0
while true
[num_top, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(6, 3, 4);
cal1 = getCalibratePDOP(distMeasured, num_bottom+num_top);
cal2 = getCalibrateTriangleSize(distMeasured, num_bottom+num_top);

err1 = getDifference(cal1, posAbsolute);
err2 = getDifference(cal2, posAbsolute);
i = i+1
if ismembertol(err1, err2, 0.0001)
    continue
else
    break
end
end
