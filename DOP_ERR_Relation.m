folderPath = 'StoredData\DOP_ERR_Relation';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)


DOP = double.empty;
ERR = double.empty;
for k = 1 : length(files)
    file_path = strcat("StoredData\DOP_ERR_Relation\", files(k).name);
    load(file_path, 'total_err', 'orders_abs')
    
    if ~isreal(total_err)  %|| b > 20
        continue
    end
    ERR = [ERR, total_err];
    DOP = [DOP, orders_abs(1,1)];
end
clearvars -except DOP ERR files

plot(DOP, ERR, "r.")
