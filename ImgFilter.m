folderPath = 'Dataset';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)
destFolder = 'NoImg';      % Specify the destination folder
% Display the names of files
length(files)
for k = 1 : length(files)
    file_path = strcat("Dataset\", files(k).name);
    load(file_path)
    if isreal(posCalibrated)        
        status = copyfile(file_path, destFolder);
    end
    %fprintf('File #%d: %s\n', k, files(k).name);
    k
end