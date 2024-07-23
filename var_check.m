for num_bottom = 4
    for num_top = 4
        for num_wall = 1
            dataFolder = strcat("StoredData/", string(num_bottom), "_", string(num_top), "_", string(num_wall));
            files = dir(fullfile(dataFolder, "*.mat"));
            for i=1:length(files)
                load(fullfile(dataFolder, files(i).name))

                disp(fullfile(dataFolder, files(i).name))
                for ii=1:5
                    PDOP_list = getPDOPList(distMeasured(:,:,ii));
                end
            end
            % fprintf("%d %d %d\n%f\n\n", num_bottom, num_top, num_wall, err/length(files));
        end
    end
end