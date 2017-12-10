function [result] = getGaussianNoiseMatrix(m, n, mu, sigma)
    result = zeros(m, n);
    f_floor = -5;
    f_ceil = 5;
    for i = 1:m
        for j = 1:n
            x = f_floor + (f_ceil - f_floor) * rand();
            result(i, j) = 1 / sqrt(2*pi*sigma*sigma) * exp(-(x-mu)^2/sigma/sigma/2);
        end
    end
end