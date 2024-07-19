folderPath = 'StoredData/New';
files = dir(fullfile(folderPath, '*.mat'));

for k = 1 : length(files)
    disp(files(k).name)
    filepath = strcat(folderPath, "/", files(k).name);
    load(filepath)
    new_err = getDifference(posAbsolute, posCalibrated);
    rse
    new_err(1)
end