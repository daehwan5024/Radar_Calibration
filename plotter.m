% plots Radars based on radarData.mat
load StoredData\2_4_1\2024_07_21_02_33_11_996.mat
close all hidden
grid on
hold on
plot3(posAbsolute(1,:), posAbsolute(2,:), posAbsolute(3,:), "b.")
% if better1
%     plot3(res(1,:), res(2,:), res(3,:), "r.")
% else
%     plot3(res2(1,:), res2(2,:), res2(3,:), "r.")
% end

for ii = 1:length(posAbsolute)
    t = text(posAbsolute(1, ii)+0.1,posAbsolute(2, ii)+0.1,posAbsolute(3, ii)+0.1,num2str(ii));
    t.Color = [0 0 1];
end