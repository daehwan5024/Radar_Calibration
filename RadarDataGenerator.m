% Makes random data for testing
if isfile("radarData.mat")
    if ~exist("prevData", "dir")
        mkdir("prevData")
    end
    timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, "-", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    fileName = strcat("prevData/", timeSTR, ".mat");
    movefile("radarData.mat", fileName);
end
num_radar = 8;
posAbsolute = rand(3, num_radar);
posAbsolute(1:2, :) = posAbsolute(1:2, :) * 20 - 10;
posAbsolute(3,1:end-1) = posAbsolute(3,1:end-1) + 2.5;

distAbsolute = pairwiseDist(posAbsolute);
distMeasured = zeros(num_radar);
% add noise to distance
for i=1:num_radar
    for j=1:i-1
        measurementError = normrnd(0, 1/30);
        distMeasured(i, j) = distAbsolute(i, j) + measurementError;
        distMeasured(j, i) = distMeasured(i, j);
    end
end
save radarData.mat num_radar posAbsolute distAbsolute distMeasured
clearvars