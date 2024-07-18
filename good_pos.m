dataFolder = "StoredData/DOP_ERR_Relation";
if ~exist(dataFolder, 'dir')
  mkdir(dataFolder)
end

function parsave(fname, posAbsolute, total_err, orders_abs)
  save(fname, 'posAbsolute', 'total_err', 'orders_abs')
end
parfor i=1:100
  [num_radar, posAbsolute, distAbsolute, distMeasured] = getRadarData();
  total_err = 0;
  PDOPList_abs = getPDOPList(distAbsolute);
  orders_abs = getInsertOrder(PDOPList_abs, num_radar);
  for ii=1:20
    distMeasured = getNoiseAdded(distAbsolute);
    posCalibrated = getCalibratedPDOP(distMeasured, num_radar);

    %for comparison
    T = getTransform(posAbsolute);
    T_r = getTransform(posCalibrated);
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
  fileName = strcat(dataFolder, "/", timeSTR, ".mat");
  parsave(fileName, posAbsolute, total_err, orders_abs);
end