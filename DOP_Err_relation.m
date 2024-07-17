folderPath = 'StoredData\DOP_ERR_Relation15';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)


DOP = double.empty;
ERR = double.empty;
for k = 1 : length(files)
    file_path = strcat("StoredData\DOP_ERR_Relation15\", files(k).name);
    load(file_path, 'b', 'c')
    if ~isreal(b)  %|| b > 20
        continue
    end
    ERR = [ERR, b];
    DOP = [DOP, c(1,1)];
end
clearvars -except DOP ERR files

plot(DOP, ERR, "r.")