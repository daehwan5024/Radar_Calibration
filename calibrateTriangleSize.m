function [posCalibrated] = calibrateTriangleSize(distMeasured, num_radar)
  if num_radar < 3
    fprintf("Nead at least 3 radars\n")
  end
  triangleList = getTriangleList(distMeasured);

  radar1 = triangleList(1, 2);
  radar2 = triangleList(1, 3);
  radar3 = triangleList(1, 4);

  [x2, x3, y3] = getTriangle(distMeasured(radar1, radar2), distMeasured(radar2, radar3), distMeasured(radar1, radar3));
  known(radar1) = true;

  posCalibrated(1,radar2) = x2;
  known(radar2) = true;

  posCalibrated(1,radar3) = x3;
  posCalibrated(2,radar3) = y3;
  known(radar3) = true;

  triangleList_index = 1;
  while ~all(known)
    for target_radar = 1:num_radar
      if known(target_radar)
        continue
      end
      pos1 = trilateration(posCalibrated(:, [radar1 radar2 radar3]), ...
            [distMeasured(target_radar, radar1), distMeasured(target_radar, radar2), distMeasured(target_radar, radar3)]);
      if ~isreal(pos1)
        continue
      end
      pos2 = trilateration(posCalibrated(:, [radar1 radar3 radar2]), ...
            [distMeasured(target_radar, radar1), distMeasured(target_radar, radar3), distMeasured(target_radar, radar2)]);
      posCalibrated(:,target_radar) = selectBetter(pos1, pos2, target_radar, posCalibrated, distMeasured, known);
      known(target_radar) = true;
    end
    triangle_found = false;
    while triangleList_index <= height(triangleList)
      triangleList_index = triangleList_index + 1;
      radar1 = triangleList(triangleList_index, 2); radar2 = triangleList(triangleList_index, 3);
      radar3 = triangleList(triangleList_index, 4);
      if known(radar1) && known(radar2) && known(radar3)
        triangle_found = true;
        break
      end
    end
    if ~triangle_found
      fprintf("data can't be used to calibrate");
    end
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