[num_top, num_bottom, posAbsolute, distAbsolute, distMeasured] = getRadarData2(10, 3, 4);
for i=1:num_top+num_bottom
    for j=1:num_top+num_bottom
        if i>num_bottom && j>num_bottom
            if distMeasured(i, j)>=20
                distMeasured(i, j) = nan;
            end
        end
    end
end
tic
posCal = getCalibrateTriangleSize(distMeasured, num_bottom+num_top);
toc
tic
posCal2 = getCalibrateTriangleSize(distMeasured, num_bottom+num_top);
toc
err = getDifference(posCal, posAbsolute);
err2 = getDifference(posCal2, posAbsolute);
run plotter.m