function[total_bytes]= getFolderSize()
    D = dir('Dataset2/*.mat'); % descends current folder and its sub-folders
    total_bytes = 0;
    for ii = 1:length(D)
        total_bytes = total_bytes + D(ii).bytes;
    end
end
for k=1:5000
    run("RadarDataGenerator.m")
    run("GradientDOP.mlx")
    file_name = sprintf("%.10f", rse);
    timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, "-", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    file_name = strcat(file_name, "___", timeSTR);
    file_name = strcat("Dataset2/", file_name, ".mat");
    save(file_name)
end