% plots Radars based on radarData.mat
load StoredData/DOP_ERR_Relation15/2024_07_17_10_54_02_933.mat
close all hidden
grid on
hold on
plot3(a(1,:), a(2,:), a(3,:), "b.")
% if better1
%     plot3(res(1,:), res(2,:), res(3,:), "r.")
% else
%     plot3(res2(1,:), res2(2,:), res2(3,:), "r.")
% end
for ii = 1:length(a)
    t = text(a(1, ii)+0.1,a(2, ii)+0.1,a(3, ii)+0.1,num2str(ii));
    t.Color = [0 0 1];
end
disp(b)