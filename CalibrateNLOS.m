% [num_top, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(5, 3, 4);

load test.mat
for i=1:num_top+num_bottom
    for j=1:num_top+num_bottom
        if i>num_bottom && j>num_bottom && distMeasured(i, j)>=20
            distMeasured(i, j) = nan;
        end
    end
end
tic
posCal = getCalibrateTriangleSize(distMeasured, num_bottom+num_top);
toc
err = getDifference(posCal, posAbsolute);
