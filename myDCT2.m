function [result] = myDCT2(arr, flag)
    [len1, ~] = size(arr);
    coefficient = zeros(len1);
    
    % 获取DCT系数矩阵
%     sqr = 1/sqrt(len1);
%     for i = 1:len1
%         coefficient(1, i) = sqr;
%     end
    for i = 1:len1
        for j = 1:len1
            if i == 1
                a = sqrt(1/len1);
            else
                a = sqrt(2/len1);
            end
            coefficient(i, j) = a * cos((i-1)*((j-1)+0.5)*pi/len1);
        end
    end
    
    if flag == 0
        result = coefficient * arr * coefficient';
    elseif flag == 1
        result = coefficient' * arr * coefficient;
    end
end