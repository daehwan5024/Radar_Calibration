files = dir("StoredData/**/*.mat");
for iterator=1:length(files)
    clearvars -except files iterator
    fullpath = fullfile(files(iterator).folder, files(iterator).name);
    load(fullpath)
    if ~exist('posCalibrated', 'var')
        continue
    end
    PDOP_List = getPDOPList(getPairwiseDist(posAbsolute));
    orders = getInsertOrder(PDOP_List, width(posAbsolute));
    DOP = orders(1, 1)/(width(posAbsolute) - 3);
    save(fullpath, 'posAbsolute', 'distMeasured', 'posCalibrated', 'errorMean', 'DOP')
end