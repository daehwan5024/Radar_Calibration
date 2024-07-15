% plots Radars based on radarData.mat
load radarData.mat
close all hidden
grid on
hold on
plot3(posAbsolute(1,:), posAbsolute(2,:), posAbsolute(3,:), "b.")
% plot3(posCalibrated(1,:), posCalibrated(2,:), posCalibrated(3,:), "r.")
for ii = 1:length(posAbsolute)
    t = text(posAbsolute(1, ii),posAbsolute(2, ii),posAbsolute(3, ii),num2str(ii));
    t.Color = [0 0 1];
end