% [num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(5, 3, 4);
% posCalibrated = getCalibratePDOP(distMeasured, num_radar+num_bottom);

T = getTransform(posAbsolute);
T_r = getTransform(posCalibrated);
res = T_r*[posCalibrated;ones(1,num_radar+num_bottom)];
real = T*[posAbsolute;ones(1,num_radar+num_bottom)];
res = res(1:3,:);
real = real(1:3,:);
res2 = [res(1:2,:); -res(3,:)];
if sqrt(sum((res - real).^2, "all")) < sqrt(sum((res2 - real).^2, "all"))
    better1 = true;
    difference = res - real(1:3,:);
    rse = sqrt(sum((res - real).^2, "all"));
else
    better1 = false;
    difference = res2 - real;
    rse = sqrt(sum((res2 - real).^2, "all"));
end
rse
difference