
num_top = 5;
num_bottom = 3;
num_wall = 4;
[num_top, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(num_top, num_bottom, num_wall);
tic
posCalibrated = getCalibratePDOP(distMeasured, num_top+num_bottom);
toc
diff = getDifference(posAbsolute, posCalibrated);
disp(diff)
T1 = getTransform(posAbsolute(:,[diff(2), diff(3), diff(4)]));
T2 = getTransform(posCalibrated(:,[diff(2), diff(3), diff(4)]));

pos1 = T1 * [posAbsolute; ones(1,num_top+num_bottom)];
pos2 = T2 * [posCalibrated; ones(1,num_top+num_bottom)];

% plots Radars based on radarData.mat
close all hidden
grid on
hold on
plot3(pos1(1,:), pos1(2,:), pos1(3,:), "b.")
plot3(pos2(1,:), pos2(2,:), pos2(3,:), "r.")

for ii = 1:length(pos1)
    t = text(pos1(1, ii)+0.1,pos1(2, ii)+0.1,pos1(3, ii)+0.1,num2str(ii));
    t.Color = [0 0 1];
end