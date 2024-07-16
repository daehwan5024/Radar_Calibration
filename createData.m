function[radar1, radar2, radar3] = findPairs(target, usable, pdopList)
% return 3 points to find target with usable
    for ii = 1:height(pdopList)
        if pdopList(ii, 2) ~= target
            continue
        end
        if ismember(pdopList(ii, 3), usable) && ismember(pdopList(ii, 4), usable) && ismember(pdopList(ii, 5), usable)
            radar1 = pdopList(ii, 3);radar2 = pdopList(ii, 4);radar3 = pdopList(ii, 5);
            return
        end
    end
    radar1 = 0;radar2 = 0;radar3 = 0;
end

function parsave(fname, a, b, c, d)
  save(fname, 'a', 'b', 'c', 'd')
end
tic
parfor k=1:10
    num_radar = 8;
    posAbsolute = rand(3, num_radar);
    posAbsolute(1:2, :) = posAbsolute(1:2, :) * 20 - 10;
    posAbsolute(3,1:end-3) = posAbsolute(3,1:end-3) + 2.5;

    distAbsolute = pairwiseDist(posAbsolute);
    distMeasured = addNoise(distAbsolute);
    
    
    pdopList = getDOPList(distMeasured);
    orders = insertOrder(pdopList, num_radar);
    posCalibrated = zeros(3, num_radar);
    
    
    
    order = orders(1,2:end);
    [x2, x3, y3] = getTriangle(distMeasured(order(1), order(2)), distMeasured(order(2), order(3)), distMeasured(order(1), order(3)));
    
    posCalibrated(:,order(2)) = [x2;0;0];
    posCalibrated(:,order(3)) = [x3;y3;0];
    known = false(1,num_radar);
    known(order(1)) = true;
    known(order(2)) = true;
    known(order(3)) = true;
    for i=4:width(order)
        target_radar = order(i);
        [radar1, radar2, radar3] = findPairs(target_radar, order(1:i-1), pdopList);
        pos1 = trilateration(posCalibrated(:,[radar1, radar2, radar3]), ...
               [distMeasured(target_radar, radar1), distMeasured(target_radar, radar2), distMeasured(target_radar, radar3)]);
        pos2 = trilateration(posCalibrated(:,[radar1 radar3 radar2]), ...
               [distMeasured(target_radar, radar1), distMeasured(target_radar, radar3), distMeasured(target_radar, radar2)]);
        posCalibrated(:,target_radar) = selectBetter(pos1, pos2, target_radar, posCalibrated, distMeasured, known);
        known(target_radar) = true;
    end
    
    for grad_iter=1:500000
        loss = zeros(3, num_radar);
        for i= 1:num_radar
            loss_t = zeros(3, 1);
            for j=1:num_radar
                if i==j
                    continue
                end
                dist_ij = norm(posCalibrated(:,i) - posCalibrated(:,j));
                const = (dist_ij - distMeasured(i, j))/dist_ij;
                loss_t = loss_t + 2*const*(posCalibrated(:,i) - posCalibrated(:,j));
            end
            loss(:,i) = loss_t;
        end
        posCalibrated = posCalibrated - loss * 0.0005;
    end
    
    % for comparison
    T = coordinateTransform(posAbsolute);
    T_r = coordinateTransform(posCalibrated);
    res = T_r\[posCalibrated;ones(1,num_radar)];
    real = T\[posAbsolute;ones(1,num_radar)];
    res = res(1:3,:);
    real = real(1:3,:);
    res2 = [res(1:2,:); -res(3,:)];
    if sqrt(sum((res - real).^2, "all")) < sqrt(sum((res2 - real).^2, "all"))
        better1 = true;
        difference = res - real(1:3,:);
        rse = sqrt(sum((res - real).^2, "all"));
    else
        better1 = false;
        difference = res2 - real;
        rse = sqrt(sum((res2 - real).^2, "all"));
    end
    file_name = sprintf("%.10f", rse);
    timeSTR = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    timeSTR = strrep(timeSTR, "/", "_");
    timeSTR = strrep(timeSTR, " ", "_");
    timeSTR = strrep(timeSTR, "-", "_");
    timeSTR = strrep(timeSTR, ":", "_");
    file_name = strcat(file_name, "___", timeSTR);
    file_name = strcat("StoredData/Dataset3/", file_name, ".mat");
    parsave(file_name, rse, posAbsolute, distMeasured, posCalibrated);
end
toc