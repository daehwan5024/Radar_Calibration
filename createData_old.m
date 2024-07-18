dataFolder = "StoredData/Dataset3";
if ~exist(dataFolder, 'dir')
    mkdir(dataFolder)
end

tic
for k=1:10
    run("RadarDataGenerator.m")
    run("GradientDOP.mlx")
    file_name = sprintf("%.10f", rse);
    timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, "-", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    file_name = strcat(file_name, "___", timeSTR);
    file_name = strcat(dataFolder, "/", file_name, ".mat");
    save(file_name)
end
toc