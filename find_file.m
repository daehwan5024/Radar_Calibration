folderPath = 'StoredData\DOP_ERR_Relation';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)


for k = 1 : length(files)
    file_path = strcat("StoredData\DOP_ERR_Relation\", files(k).name);
    load(file_path, 'b', 'c')
    if ~isreal(b)
        continue
    end
    if ismembertol(b, 8.328, 0.001)
        fprintf("%s\n", files(k).name)
    end
end