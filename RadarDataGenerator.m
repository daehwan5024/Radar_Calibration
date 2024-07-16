% Makes random data for testing

% Save previous file based on time
if isfile("radarData.mat")
    if ~exist("StoredData\prevData", "dir")
        mkdir("StoredData\prevData")
    end
    timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, "-", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    fileName = strcat("StoredData\prevData\", timeSTR, ".mat");
    movefile("radarData.mat", fileName);
end

% Generate Datas
num_radar = 8;
posAbsolute = rand(3, num_radar);
posAbsolute(1:2, :) = posAbsolute(1:2, :) * 20 - 10;
posAbsolute(3,1:end-3) = posAbsolute(3,1:end-3) + 2.5;

distAbsolute = pairwiseDist(posAbsolute);
distMeasured = addNoise(distAbsolute);

save radarData.mat num_radar posAbsolute distAbsolute distMeasured
clearvars