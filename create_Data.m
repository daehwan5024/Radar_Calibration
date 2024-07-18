dataFolder = "StoredData/Dataset3";
if ~exist(dataFolder, 'dir')
    mkdir(dataFolder)
end

function parsave(fname, rse, posAbsolute, distMeasured, posCalibrated)
  save(fname, 'rse', 'posAbsolute', 'distMeasured', 'posCalibrated')
end
tic
parfor k=1:10
    [num_radar, posAbsolute, distAbsolute, distMeasured] = getRadarData();
    
    posCalibrated = getCalibratePDOP(distMeasured, num_radar);
    
    % for comparison
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
    file_name = sprintf("%.10f", rse);
    timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, "-", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    file_name = strcat(file_name, "___", timeSTR);
    file_name = strcat(dataFolder, "/", file_name, ".mat");
    parsave(file_name, rse, posAbsolute, distMeasured, posCalibrated);
end
toc