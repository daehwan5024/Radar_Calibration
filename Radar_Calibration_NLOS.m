% generate data
%
num_top = 4;
num_bottom = 3;
num_wall = 4;
rand_pos = rand(num_top, 1) * 20 * num_wall;

for i=1:num_wall
    rand_pos(i) = rand(1) * 20 + 20*(i-1);
end
posAbsolute = rand(3, num_top) + 2.5;
for i=1:num_top
    if rand_pos(i) <= 20
        posAbsolute(1, i) = rand_pos(i) - 10;
        posAbsolute(2, i) = -10;
    elseif rand_pos(i) <= 40
        posAbsolute(1, i) = 10;
        posAbsolute(2, i) = rand_pos(i) - 30;
        
    elseif rand_pos(i) <= 60
        posAbsolute(1, i) = 50 - rand_pos(i);
        posAbsolute(2, i) = 10;
    else
        posAbsolute(1, i) = -10;
        posAbsolute(2, i) = 70 - rand_pos(i);
    end
end

centerPos = rand(3,1);
centerPos(3,1) = 0;
centerPos(1:2,1) = centerPos(1:2,1) * 20 -10;
theta = rand(1) * 2*pi;
rotationMatrix = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
posBottom = rotationMatrix * [0, -0.5, 0.5; 1/sqrt(3), -1/(2*sqrt(3)), -1/(2*sqrt(3)); 0,0,0] + centerPos;
posAbsolute = [posBottom, posAbsolute];


for i=1:num_wall
    rand_pos(i) = rand(1) * 20 + 20*(i-1);
end
posAbsolute2 = rand(3, num_top) + 2.5;
for i=1:num_top
    if rand_pos(i) <= 20
        posAbsolute2(1, i) = rand_pos(i) - 10;
        posAbsolute2(2, i) = -10;
    elseif rand_pos(i) <= 40
        posAbsolute2(1, i) = 10;
        posAbsolute2(2, i) = rand_pos(i) - 30;
        
    elseif rand_pos(i) <= 60
        posAbsolute2(1, i) = 50 - rand_pos(i);
        posAbsolute2(2, i) = 10;
    else
        posAbsolute2(1, i) = -10;
        posAbsolute2(2, i) = 70 - rand_pos(i);
    end
end

centerPos = rand(3,1);
centerPos(3,1) = 0;
centerPos(1:2,1) = centerPos(1:2,1) * 20 -10;
theta = rand(1) * 2*pi;
rotationMatrix = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
posBottom = rotationMatrix * [0, -0.5, 0.5; 1/sqrt(3), -1/(2*sqrt(3)), -1/(2*sqrt(3)); 0,0,0] + centerPos;
posAbsolute2 = [posBottom, posAbsolute2];
posAbsolute2(1,:)= posAbsolute2(1,:) + 25;
posAbsolute = [posAbsolute, posAbsolute2];

distAbsolute = getPairwiseDist(posAbsolute);
distMeasured = NaN(size(distAbsolute));
distMeasured(1:7,1:7) = getNoiseAdded2(distAbsolute(1:7,1:7), num_bottom);
distMeasured(8:14,8:14) = getNoiseAdded2(distAbsolute(8:14,8:14), num_bottom);


%create Data



