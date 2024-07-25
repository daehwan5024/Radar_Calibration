function [posCalibrated] = getCalibratePDOP(distMeasured, num_radar)
    % returns calibrated position
    % uses PDOP and gradient descent
    if num_radar < 3
      fprintf("Need at least 3 radars\n")
    end

    pdopList = getPDOPList(distMeasured);
    orders = getInsertOrder(pdopList, num_radar);
    posCalibrated = zeros(3, num_radar);

    function[radar1, radar2, radar3] = findPairs(target, usable)
        for ii = 1:height(pdopList)
            if pdopList(ii, 2) ~= target
                continue
            end
            if ismember(pdopList(ii, 3), usable) && ismember(pdopList(ii, 4), usable) && ismember(pdopList(ii, 5), usable)
                radar1 = pdopList(ii, 3); radar2 = pdopList(ii, 4); radar3 = pdopList(ii, 5);
            return
            end
        end
        radar1 = 0;radar2 = 0;radar3 = 0;
    end

    order = orders(1, 2:end);
    [x2, x3, y3] = getTriangle( distMeasured(order(1), order(2)), distMeasured(order(2), order(3)), distMeasured(order(1), order(3)) );
    posCalibrated(:,order(2)) = [x2;0;0];
    posCalibrated(:,order(3)) = [x3;y3;0];
    known = false(1,num_radar);
    known(order(1)) = true;
    known(order(2)) = true;
    known(order(3)) = true;

    for i=4:width(order)
        target_radar = order(i);
        [radar1, radar2, radar3] = findPairs(target_radar, order(1:i-1));
        if radar1 == 0 || radar2 == 0 || radar3 == 0
            posCalibrated(1,1) = 1i;
            posCalibrated(2,1) = 1i;
            posCalibrated(3,1) = 1i;
            return
        end
        pos1 = getTrilateration(posCalibrated(:,[radar1, radar2, radar3]), ...
                [distMeasured(target_radar, radar1), distMeasured(target_radar, radar2), distMeasured(target_radar, radar3)]);
        pos2 = getTrilateration(posCalibrated(:,[radar1 radar3 radar2]), ...
                [distMeasured(target_radar, radar1), distMeasured(target_radar, radar3), distMeasured(target_radar, radar2)]);
        posCalibrated(:,target_radar) = getBetter(pos1, pos2, target_radar, posCalibrated, distMeasured, known);
        known(target_radar) = true;
    end

    for grad_iter=1:500000 % gradient descent
        loss = zeros(3, num_radar);
        for i= 1:num_radar
            loss_t = zeros(3, 1);
            for j=1:num_radar
                if i==j
                    continue
                end
                if isnan(distMeasured(i, j))
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
end