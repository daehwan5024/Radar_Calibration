function [distance] = pairwiseDist(positions)
%PAIRWISEDIST Calculate pairwise distance of Positions
%positions should contain position of n radars, each position should be a
%column vector

n = width(positions);
distance = zeros(n);
for i=1:n
    for j=1:n
        distance(i, j) = norm(positions(:,i) - positions(:,j));
    end
end
end

