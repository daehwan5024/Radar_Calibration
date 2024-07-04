function [triangleList] = getTriangleList(distance)
%TRIANGLELIST 이 함수의 요약 설명 위치
%   자세한 설명 위치
n = width(distance);
triangleList = double.empty;
for i=1:n
    for j=1:i-1
        for k=1:j-1
            a=distance(i, j); b=distance(j,k); c=distance(k,i); s=(a+b+c)/2;
            area = sqrt(s*(s-a)*(s-b)*(s-c));
            if ~isreal(area)
                fprintf("FAILED")
                continue
            end
            triangleList = [triangleList;area, k, j, i];
        end
    end
end
triangleList = sortrows(triangleList, "descend");
end

