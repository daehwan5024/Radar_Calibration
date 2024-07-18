folderPath = 'StoredData\Dataset2';
files = dir(fullfile(folderPath, '*.mat'));  
destFolder = 'StoredData\NoImg2';

length(files)
for k = 1 : length(files)
    file_path = strcat("StoredData\Dataset2\", files(k).name);
    load(file_path)
    if isreal(posCalibrated)
        status = copyfile(file_path, destFolder);
    end
    %fprintf('File #%d: %s\n', k, files(k).name);
    k
end