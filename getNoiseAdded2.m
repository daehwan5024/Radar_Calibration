function [noise] = getNoiseAdded2(real, num_bottom)
    % Add noise to real
    % real should be a square matrix
noise = zeros(size(real));
for i=1:width(real)
    for j=1:i-1
        if i<=num_bottom && j<=num_bottom
            normNoise = 0;
        else
            normNoise = normrnd(0,1/30);
        end
        noise(i, j) = real(i, j) + normNoise;
        noise(j, i) = noise(i, j);
    end
end
end
