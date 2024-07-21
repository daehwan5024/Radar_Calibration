function parsave(fname, meanError, posAbsolute, posCalibrated)
    [filepath,~,~] = fileparts(fname);
    if ~exist(filepath, "dir")
        mkdir(filepath)
    end
    save(fname, 'meanError', 'posAbsolute', 'posCalibrated')
end
for num_top = 4:6
    for num_bottom = 2:3
        for num_wall = 1:4
            dataFolder = strcat("StoredData/", string(num_bottom), "_", string(num_top), "_", string(num_wall));
            fprintf("%d %d %d\n", num_bottom, num_top, num_wall);
            tic
            parfor k=1:50
                [~, ~, posAbsolute, distAbsolute, distMeasured] = getRadarData2(num_top, num_bottom, num_wall);
                meanError = 0;
                for i=1:20
                    distMeasured = getNoiseAdded(distAbsolute)
                    posCalibrated = getCalibratePDOP(distMeasured, num_top+num_bottom);
                    diff = getDifference(posAbsolute, posCalibrated);
                    meanError = meanError + diff(1,1);
                end
                meanError = meanError/20;
                Ts = datetime();
                Ts.Format = 'uuuu/MM/dd HH:mm:ss.SSS';
                timeSTR = string(Ts);
                timeSTR = strrep(timeSTR, "/", "_"); timeSTR = strrep(timeSTR, " ", "_");
                timeSTR = strrep(timeSTR, ":", "_"); timeSTR = strrep(timeSTR, ".", "_");
                file_name = strcat(dataFolder, "/", timeSTR, ".mat");
                parsave(file_name, meanError, posAbsolute, posCalibrated);
            end
            toc
        end
    end
end