function [transformMatrix] = getTransform(result)
% 4x4 transform Matrix based on result
% First 3 points of result will be transformed to
% (0,0,0), (x2,0,0), (x3,y3,0) using rotation and translation

    transformMatrix = zeros(4);
    transformMatrix(4,4) = 1;

    translation = eye(4);
    translation(1:3,4) = -result(:,1);

    relative_vec = result - result(:,1);
    cosTheta1 = relative_vec(1,2)/sqrt(relative_vec(1,2)^2 + relative_vec(2,2)^2);
    sinTheta1 = -relative_vec(2,2)/sqrt(relative_vec(1,2)^2 + relative_vec(2,2)^2);
    cosTheta2 = sqrt(relative_vec(1,2)^2 + relative_vec(2,2)^2) / sqrt(relative_vec(1:3,2)' * relative_vec(1:3,2));
    sinTheta2 = relative_vec(3,2)/sqrt(relative_vec(1:3,2)' * relative_vec(1:3,2));

    Tprime = [cosTheta2, 0, sinTheta2;0,1,0;-sinTheta2,0,cosTheta2] * ...
             [cosTheta1, -sinTheta1,0;sinTheta1, cosTheta1, 0;0,0,1];
    p3_prime = Tprime * relative_vec(1:3,3);
    cosTheta3 = p3_prime(2)/sqrt(p3_prime(2)^2 + p3_prime(3)^2);
    sinTheta3 = -p3_prime(3)/sqrt(p3_prime(2)^2 + p3_prime(3)^2);

    rotations = [1,0,0;0,cosTheta3,-sinTheta3;0,sinTheta3,cosTheta3]*Tprime;
    transformMatrix(1:3,1:3) = (rotations);
    transformMatrix = transformMatrix*translation;
end
