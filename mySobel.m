function [result] = mySobel(oriImage)
    [m, n] = size(oriImage);
    result = zeros(m-2, n-2);
    Gx = zeros(m-2, n-2);
    Gy = zeros(m-2, n-2);
    for i = 2:m-1
        for j = 2:n-1
            Gx(i-1, j-1) = (-1)*oriImage(i-1, j-1) + (-2)*oriImage(i, j-1) + (-1)*oriImage(i+1, j-1) + oriImage(i-1, j+1) + 2*oriImage(i, j+1) + oriImage(i+1, j+1);
            Gy(i-1, j-1) = oriImage(i-1, j-1) + 2*oriImage(i-1, j) + oriImage(i-1, j+1) + (-1)*oriImage(i+1, j-1) + (-2)*oriImage(i+1, j) + (-1)*oriImage(i+1, j+1);
        end
    end
    result = sqrt(Gx.^2 + Gy.^2);
end