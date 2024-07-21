dataFolder = "StoredData/Old";
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
        posCalibrated = getCalibratePDOP(distMeasured, num_radar);

        %for comparison
        meanError = getDifference(posAbsolute, posCalibrated);
        total_err = total_err + meanError;
    end
    Ts = datetime();
    Ts.Format = 'uuuu/MM/dd HH:mm:ss.SSS';
    timeSTR = string(Ts);
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    timeSTR = strrep(timeSTR, ".", "_");
    file_name = strcat(dataFolder, "/", timeSTR, ".mat");
    parsave(file_name, posAbsolute, total_err, orders_abs);
end