folderPath = 'StoredData\**\';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .mat files (adjust file extension as needed)


PDOP = double.empty;
ERR = double.empty;
for k = 1 : length(files)
    file_path = fullfile(files(k).folder, files(k).name);
    load(file_path)
    if ~exist('DOP', 'var')
        continue
    end
    if ~isreal(errorMean)  %|| b > 20
        continue
    end
    ERR = [ERR, errorMean];
    PDOP = [PDOP, DOP];
end
clearvars -except PDOP ERR files

plot(PDOP, ERR, "r.")
disp(mean(ERR))
