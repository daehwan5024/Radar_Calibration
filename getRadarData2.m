function[num_radar, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(varargin)
    % input can be
    % num_radar
    % num_radar, num_bottom
    % num_radar, num_bottom, use_wall
    % Makes random data for testing
    num_wall = 4;
    num_radar = 4;
    num_bottom = 3;
    if nargin == 1
        num_radar = varargin{1};
    elseif nargin == 2
        num_radar = varargin{1};
        num_bottom = varargin{2};
    elseif nargin == 3
        num_radar = varargin{1};
        num_bottom = varargin{2};
        if varargin{3} > 4 || varargin{3} < 1
            fprintf("Wrong wall number")
        else
            num_wall = varargin{3};
        end
    end
    rand_pos = rand(num_radar, 1) * 20 * num_wall;
    if num_radar > num_wall
        for i=1:num_wall
            rand_pos(i) = rand(1) * 20 + 20*(i-1);
        end
    end
    posAbsolute = rand(3, num_radar) + 2.5;

    for i=1:num_radar
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
    if num_bottom == 1
        posAbsolute = [posAbsolute, centerPos];
    elseif num_bottom == 2
        posBottom = rotationMatrix * [-0.5, 0.5; 0, 0; 0,0] + centerPos;
        posAbsolute = [posAbsolute, posBottom];
    elseif num_bottom == 3
        posBottom = rotationMatrix * [0, -0.5, 0.5; 1/sqrt(3), -1/(2*sqrt(3)), -1/(2*sqrt(3)); 0,0,0] + centerPos;
        posAbsolute = [posAbsolute, posBottom];
    elseif num_bottom == 4
        posBottom = rotationMatrix * [0.5, 0.5, -0.5, -0.5; 0.5, -0.5, -0.5, 0.5; 0,0,0,0] + centerPos;
        posAbsolute = [posAbsolute, posBottom];
    else
        fprintf("Not done")
    end

    distAbsolute = getPairwiseDist(posAbsolute);
    distMeasured = getNoiseAdded(distAbsolute);
    distMeasured(num_radar+1:end, num_radar+1:end) = distAbsolute(num_radar+1:end, num_radar+1:end);
    
end