function [triangleList] = getTriangleList(distance)
% List of all possible triangle pairs
n = width(distance);
triangleList = double.empty;
for i=1:n
    for j=1:i-1
        for k=1:j-1
            a=distance(i, j); b=distance(j,k); c=distance(k,i); s=(a+b+c)/2;
            area = sqrt(s*(s-a)*(s-b)*(s-c));
            if ~isreal(area)
                continue
            end
            triangleList = [triangleList;area, k, j, i];
        end
    end
end
triangleList = sortrows(triangleList, "descend");
end

