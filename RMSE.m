function [error] = RMSE(input1, input2)
%UNTITLED calculate RMSE of the pairwise distance
%   자세한 설명 위치
if size(input1) ~= size(input2)
    fprintf("WRONG SIZE")
    error = 0;
    return
end
diff = input1 - input2;
error = sqrt(sum(diff.^2, "all")/2);
end
