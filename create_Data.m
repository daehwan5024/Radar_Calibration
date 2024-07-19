dataFolder = "StoredData/Dataset_Old";
if ~exist(dataFolder, 'dir')
    mkdir(dataFolder)
end

function parsave(fname, rmse, posAbsolute, distMeasured, posCalibrated)
  save(fname, 'rmse', 'posAbsolute', 'distMeasured', 'posCalibrated')
end
tic
parfor k=1:20
    [num_radar, posAbsolute, distAbsolute, distMeasured] = getRadarData();
    
    posCalibrated = getCalibratePDOP(distMeasured, num_radar);
    
    % for comparison
    T = getTransform(posAbsolute);
    T_r = getTransform(posCalibrated);
    res = T_r*[posCalibrated;ones(1,num_radar)];
    real = T*[posAbsolute;ones(1,num_radar)];
    res = res(1:3,:);
    real = real(1:3,:);
    res2 = [res(1:2,:); -res(3,:)];
    if sqrt(sum((res - real).^2, "all")) < sqrt(sum((res2 - real).^2, "all"))
        better1 = true;
        difference = res - real(1:3,:);
        rmse = sqrt(sum((res - real).^2, "all"))/num_radar;
    else
        better1 = false;
        difference = res2 - real;
        rmse = sqrt(sum((res2 - real).^2, "all"))/num_radar;
    end
    file_name = sprintf("%.10f", rse);
    Ts = datetime();
    Ts.Format = 'uuuu/MM/dd HH:mm:ss.SSS';
    timeSTR = string(Ts);
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    timeSTR = strrep(timeSTR, ".", "_");
    file_name = strcat(file_name, "___", timeSTR);
    file_name = strcat(dataFolder, "/", file_name, ".mat");
    parsave(file_name, rmse, posAbsolute, distMeasured, posCalibrated);
end
toc