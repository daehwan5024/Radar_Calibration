folderPath = 'StoredData\DOP_ERR_Relation15';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)


for k = 1 : length(files)
    file_path = strcat("StoredData\DOP_ERR_Relation15\", files(k).name);
    load(file_path, 'b', 'c')
    if ~isreal(b)
        continue
    end
    if ismembertol(b, 85.589, 0.001)
        fprintf("%s\n", files(k).name)
    end
end