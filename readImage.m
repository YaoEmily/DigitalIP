function [result] = readImage(image, m, n)

    result = zeros(m, n, 3);
    perLine = ceil((m * 3) / 4) * 4;
    for i = 1:m
        for j = 1:n
            lenth = 54 + ((m-i) * perLine + j * 3 - 2);
            result(i, j, 3) = bit2int(image, lenth, lenth);
            result(i, j, 2) = bit2int(image, lenth+1, lenth+1);
            result(i, j, 1) = bit2int(image, lenth+2, lenth+2);
        end
    end
    
end