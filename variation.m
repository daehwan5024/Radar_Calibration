function parsave(fname, errors, distMeasured, posCalibrated, posAbsolute)
    [filepath,~,~] = fileparts(fname);
    if ~exist(filepath, "dir")
        mkdir(filepath)
    end
    save(fname, 'errors','distMeasured', 'posCalibrated', 'posAbsolute')
end
for num_bottom = 3
    for num_top = 6
        for num_wall = 4
            dataFolder = strcat("StoredData/", string(num_bottom), "_", string(num_top), "_", string(num_wall));
            tic
            for k=1
                [~, ~, posAbsolute, distAbsolute, ~] = getRadarData2(num_top, num_bottom, num_wall);

                iteration = 5;
                posCalibrated = zeros(3, num_bottom+num_top, iteration);
                distMeasured = zeros(num_top+num_bottom, num_top+num_bottom, iteration);
                errors = zeros(4, iteration);
                for i=1:iteration
                    distMeasured(:,:,i) = getNoiseAdded2(distAbsolute, num_bottom);
                    posCalibrated(:,:,i) = getCalibratePDOP(distMeasured(:,:,i), num_top+num_bottom);
                    diff = getDifference(posAbsolute, posCalibrated(:,:,i));
                    errors(:,i) = diff;
                end
                Ts = datetime();
                Ts.Format = 'uuuu/MM/dd HH:mm:ss.SSS';
                timeSTR = string(Ts);
                timeSTR = strrep(timeSTR, "/", "_"); timeSTR = strrep(timeSTR, " ", "_");
                timeSTR = strrep(timeSTR, ":", "_"); timeSTR = strrep(timeSTR, ".", "_");
                file_name = strcat(dataFolder, "/", timeSTR, ".mat");
                parsave(file_name, errors, distMeasured, posCalibrated, posAbsolute);
            end
            toc
        end
    end
end