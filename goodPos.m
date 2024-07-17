function parsave(fname, posAbsolute, total_err, orders_abs)
  save(fname, 'posAbsolute', 'total_err', 'orders_abs')
end
parfor i=1:100
  [num_radar, posAbsolute, distAbsolute, distMeasured] = RadarDataGenerator();
  total_err = 0;
  PDOPList_abs = getDOPList(distAbsolute);
  orders_abs = insertOrder(PDOPList_abs, num_radar);
  for ii=1:20
    distMeasured = addNoise(distAbsolute);
    posCalibrated = calibratePDOP(distMeasured, num_radar);

    %for comparison
    T = coordinateTransform(posAbsolute);
    T_r = coordinateTransform(posCalibrated);
    res = T_r\[posCalibrated;ones(1,num_radar)];
    real = T\[posAbsolute;ones(1,num_radar)];
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
        total_err = total_err + rse
  end
  timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
  timeSTR = strrep(timeSTR, "/", "_");
  timeSTR = strrep(timeSTR, " ", "_");
  timeSTR = strrep(timeSTR, "-", "_");
  timeSTR = strrep(timeSTR, ":", "_");
  fileName = strcat("StoredData\DOP_ERR_Relation\", timeSTR, ".mat");
  parsave(fileName, posAbsolute, total_err, orders_abs);
end