folderPath = 'NoImg';  % Specify your folder path here
files = dir(fullfile(folderPath, '*.mat'));  % List all .txt files (adjust file extension as needed)


% PDOP = zeros(1,length(files));
% ERR = zeros(1,length(files));
% for k = 1 : length(files)
%     file_path = strcat("NoImg\", files(k).name);
%     load(file_path)
%     ERR(k) = rse;
%     for i=1:height(orders)
%         if isequal(order, orders(i, 2:9))
%             PDOP(k) = orders(i, 1);
%             break;
%         end
%     end
%     k
% end
% clearvars -except PDOP ERR files

plot(PDOP, ERR, "r.")