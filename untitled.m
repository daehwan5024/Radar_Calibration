folderPath = 'NoImg';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)

avg = 0;
for k = 1 : length(files)
    file_path = strcat("NoImg\", files(k).name);
    load(file_path, "rse")
    avg = avg + rse;
end
avg / length(files)
