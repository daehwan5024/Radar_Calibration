% plots Radars based on radarData.mat
[num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(4, 4);
close all hidden
grid on
hold on
plot3(posAbsolute(1,:), posAbsolute(2,:), posAbsolute(3,:), "b.")

for ii = 1:length(posAbsolute)
    t = text(posAbsolute(1, ii)+0.1,posAbsolute(2, ii)+0.1,posAbsolute(3, ii)+0.1,num2str(ii));
    t.Color = [0 0 1];
end