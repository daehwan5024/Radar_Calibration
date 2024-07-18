function [pdopList] = getPDOPList(distance)
%List pdop of all possible pairs.
num_radar = width(distance);
    function[pos1, pos2, pos3] = posRelative(target, radar1, radar2, radar3)
        [x2, x3, y3] = getTriangle(distance(radar1, radar2), distance(radar2, radar3), distance(radar1, radar3));
        targetPos = getTrilateration([0;0;0], [x2;0;0], [x3;y3;0],...
                    distance(target, radar1), distance(target, radar2), distance(target, radar3));
        if ~isreal(targetPos)
            pos1 = [1j;1j;1j];
            pos2 = [1j;1j;1j];
            pos3 = [1j;1j;1j];
            return
        end
        pos1 = [0;0;0] - targetPos;
        pos2 = [x2;0;0] - targetPos;
        pos3 = [x3;y3;0] - targetPos;
    end
pdopList = double.empty;
for i=1:num_radar
    for j=1:i-1
        for k=1:j-1
            for radar=1:num_radar
                if i == radar||j==radar||k==radar
                    continue
                end
                [radar1, radar2, radar3] = posRelative(radar, i, j, k);
                if ~isreal(radar1)
                    continue
                end
                A = [radar1';radar2';radar3'];
                B = A.*A;
                C=zeros(3,3);
                C(1,:)=A(1,:)/sqrt(sum(B(1,:)));
                C(2,:)=A(2,:)/sqrt(sum(B(2,:)));
                C(3,:)=A(3,:)/sqrt(sum(B(3,:)));
                D=inv(transpose(C)*C);
                pdopList = [pdopList;sqrt(D(1,1)^2+D(2,2)^2+D(3,3)^2),radar,k,j,i];
            end
        end
    end
end
pdopList = sortrows(pdopList);
end

