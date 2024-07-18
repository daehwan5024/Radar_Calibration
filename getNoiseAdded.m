function [noise] = getNoiseAdded(real)
    % Add noise to real
    % real should be a square matrix
noise = zeros(size(real));
for i=1:width(real)
    for j=1:i-1
        normNoise = normrnd(0,1/30);
        noise(i, j) = real(i, j) + normNoise;
        noise(j, i) = noise(i, j);
    end
end
end

