function [x2, x3, y3] = getTriangle(dist12, dist23, dist13)
    x2 = dist12;
    x3 = (x2^2 + dist13^2 - dist23^2)/(2*x2);
    y3 = sqrt(dist13^2 - x3^2);
end

