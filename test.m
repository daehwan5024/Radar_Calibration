function[total_bytes]= getFolderSize()
    D = dir('Dataset/*.mat'); % descends current folder and its sub-folders
    total_bytes = 0;
    for ii = 1:length(D)
        total_bytes = total_bytes + D(ii).bytes;
    end
end
getFolderSize()
