function [result] = myDFT2(arr, flag)
    [len1, len2, len3] = size(arr);

    if(len3 == 1) % 没有复数，添加复数维度为0
        arr(:, :, 2) = 0;
    end
    result = zeros(len1, len2, 2);

    % 行变换
    tmp = permute(arr, [3, 2, 1]);
    result = permute(result, [3, 2, 1]);
    for i = 1:len1
        result(:, :, i) = myDFT(tmp(:, :, i), flag);
    end
    result = permute(result, [3, 2, 1]);
    
    % 列变换
    result = permute(result, [3, 1, 2]);
    for i = 1:len2
        result(:, :, i) = myDFT(result(:, :, i), flag);
    end
    result = permute(result, [2, 3, 1]);
    
end