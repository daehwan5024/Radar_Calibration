% plots Radars based on radarData.mat
load radarData.mat
close all hidden
grid on
hold on
plot3(real(1,:), real(2,:), real(3,:), "b.")
plot3(posCalibrated(1,:), posCalibrated(2,:), posCalibrated(3,:), "r.")
for ii = 1:length(posAbsolute)
    t = text(real(1, ii),real(2, ii),real(3, ii),num2str(ii));
    t.Color = [0 0 1];
end