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
    meanError = getDifference(posAbsolute, posCalibrated);
    Ts = datetime();
    Ts.Format = 'uuuu/MM/dd HH:mm:ss.SSS';
    timeSTR = string(Ts);
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    timeSTR = strrep(timeSTR, ".", "_");
    file_name = strcat(dataFolder, "/", timeSTR, ".mat");
    parsave(file_name, meanError, posAbsolute, distMeasured, posCalibrated);
end
toc