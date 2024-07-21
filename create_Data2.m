dataFolder = "StoredData/Dataset_New";
if ~exist(dataFolder, 'dir')
    mkdir(dataFolder)
end

function parsave(fname, rmse, posAbsolute, distMeasured, posCalibrated)
    save(fname, 'rmse', 'posAbsolute', 'distMeasured', 'posCalibrated')
end

tic
parfor k=1:20
    [num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(5, 3, 4);
    posCalibrated = getCalibratePDOP(distMeasured, num_radar+num_bottom);

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