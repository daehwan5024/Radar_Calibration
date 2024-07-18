function [betterPos] = getBetter(new1, new2, newIndex, posCalibrated, distance, known)
%Choose better between new1 and new2

known(newIndex) = true;
    function[error] = rmse_modified(input1, input2)
        assert(isequal(size(input1), size(input2)))
        error = 0;
        for i=1:height(input1)
            for j=1:width(input1)
                if(known(i) && known(j))
                    error = error + (input1(i, j) - input2(i, j))^2;
                end
            end
        end
    end
pos1 = posCalibrated;
pos2 = posCalibrated;
pos1(:,newIndex) = new1;
pos2(:,newIndex) = new2;

e1 = rmse_modified(getPairwiseDist(pos1), distance);
e2 = rmse_modified(getPairwiseDist(pos2), distance);

if e1 < e2
    betterPos = new1;
else
    betterPos = new2;
end
end

