folderPath = 'StoredData\NoImg2';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)


AVGDIST = zeros(1,length(files));
ERR = zeros(1,length(files));
for k = 1 : length(files)
    file_path = strcat("StoredData\NoImg2\", files(k).name);
    load(file_path, "rse", "distAbsolute")
    ERR(k) = rse;
    AVGDIST(k) = sum(distAbsolute, "all")/56;
    k
end
clearvars -except AVGDIST ERR files

plot(AVGDIST, ERR, "r.")