function [result] = getSaltPepperNoiseMatrix(gray, para)
    [m, n] = size(gray);
    result = zeros(m, n);
    for i = 1:m
        for j = 1:n
            tmp = rand();
            if tmp > 1-para
                result(i, j) = 0;
            elseif tmp < para
                result(i, j) = 1;
            else
                result(i, j) = gray(i, j);
            end
        end
    end
end