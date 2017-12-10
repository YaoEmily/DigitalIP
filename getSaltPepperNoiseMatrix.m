function [result] = getSaltPepperNoiseMatrix(gray)
    [m, n] = size(gray);
    result = zeros(m, n);
    for i = 1:m
        for j = 1:n
            tmp = rand();
            if tmp > 0.95
                result(i, j) = 0;
            elseif tmp < 0.05
                result(i, j) = 255;
            else
                result(i, j) = gray(i, j);
            end
        end
    end
end