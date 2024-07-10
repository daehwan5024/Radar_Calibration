num_radar = 5;
posAbsolute = [10, 10, -10, -10, 0;...
               10, -10, 10, -10, 0;...
               3.5, 3.5, 3.5, 3.5, 0];
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