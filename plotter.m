% plots Radars based on radarData.mat
load radarData.mat
close all hidden
grid on
hold on
plot3(posAbsolute(1,:), posAbsolute(2,:), posAbsolute(3,:), "b.")
for ii = 1:length(posAbsolute)
    t = text(posAbsolute(1, ii),posAbsolute(2, ii),posAbsolute(3, ii),num2str(ii));
    t.Color = [1 0 0];
end