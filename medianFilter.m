function [result] = medianFilter(oriImage)
    [m, n] = size(oriImage);
    result = zeros(m, n);
    for i = 1:m
        for j = 1:n
            if i == 1 && j == 1
                arr = zeros(1, 4);
                arr(1) = oriImage(i, j+1); arr(2) = oriImage(i+1, j); arr(3) = oriImage(i+1, j+1); arr(4) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(2)+arr(3))/2;
            elseif i == 1 && j == n
                arr = zeros(1, 4);
                arr(1) = oriImage(i, j-1); arr(2) = oriImage(i+1, j-1); arr(3) = oriImage(i+1, j); arr(4) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(2)+arr(3))/2;
            elseif i == m && j == 1
                arr = zeros(1, 4);
                arr(1) = oriImage(i-1, j); arr(2) = oriImage(i-1, j+1); arr(3) = oriImage(i, j+1); arr(4) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(2)+arr(3))/2;
            elseif i == m && j == n
                arr = zeros(1, 4);
                arr(1) = oriImage(i-1, j-1); arr(2) = oriImage(i-1, j); arr(3) = oriImage(i, j-1); arr(4) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(2)+arr(3))/2;
            elseif i == 1
                arr = zeros(1, 6);
                arr(1) = oriImage(i, j-1); arr(3) = oriImage(i, j+1); arr(3) = oriImage(i+1, j-1); arr(4) = oriImage(i+1, j); arr(5) = oriImage(i+1, j+1); arr(6) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(3)+arr(4))/2;
            elseif i == m
                arr = zeros(1, 6);
                arr(1) = oriImage(i-1, j-1); arr(3) = oriImage(i-1, j); arr(3) = oriImage(i-1, j+1); arr(4) = oriImage(i, j-1); arr(5) = oriImage(i, j+1); arr(6) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(3)+arr(4))/2;
            elseif j == 1
                arr = zeros(1, 6);
                arr(1) = oriImage(i-1, j); arr(3) = oriImage(i-1, j+1); arr(3) = oriImage(i, j+1); arr(4) = oriImage(i+1, j); arr(5) = oriImage(i+1, j+1); arr(6) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(3)+arr(4))/2;
            elseif j == n
                arr = zeros(1, 6);
                arr(1) = oriImage(i-1, j-1); arr(3) = oriImage(i-1, j); arr(3) = oriImage(i, j-1); arr(4) = oriImage(i+1, j-1); arr(5) = oriImage(i+1, j); arr(6) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = (arr(3)+arr(4))/2;
            else
                arr = zeros(1, 9);
                arr(1) = oriImage(i-1, j-1); arr(3) = oriImage(i-1, j); arr(3) = oriImage(i-1, j+1); arr(4) = oriImage(i, j-1); arr(5) = oriImage(i, j+1); arr(6) = oriImage(i+1, j-1); arr(7) = oriImage(i+1, j); arr(8) = oriImage(i+1, j+1); arr(9) = oriImage(i, j);
                arr = sort(arr);
                result(i, j) = arr(5);
            end
        end
    end
end