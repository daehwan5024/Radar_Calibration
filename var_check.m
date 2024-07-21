for num_top = 4:5
    for num_bottom = 2:3
        for num_wall = 1:4
            dataFolder = strcat("StoredData/", string(num_bottom), "_", string(num_top), "_", string(num_wall));
            files = dir(fullfile(dataFolder, "*.mat"));
            err = 0;
            for i=1:length(files)
                load(fullfile(dataFolder, files(i).name))
                err = err + meanError(1,1);
            end
            fprintf("%d %d %d\n%f\n\n", num_bottom, num_top, num_wall, err/length(files));
        end
    end
end