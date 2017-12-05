function [result] = myDFT(arr, flag)
    [len1, len2] = size(arr);
    
    if len1~=1 && len1~=2
        fprintf('Thire is something wrong.\n');
    end
    if(len1 == 1) % 没有虚部，添加虚部维度为0
        arr(2, :) = 0;
    end
    result = zeros(2, len2);
    PI2_N = 2*pi/len2;
    
    if(flag == 0) % 正变换
        for i = 1:len2
            for j = 1:len2
                result(1, i) = result(1, i) + arr(1, j) * cos(PI2_N*i*j) + arr(2, j) * sin(PI2_N*i*j); % 计算实部
                result(2, i) = result(2, i) - arr(1, j) * sin(PI2_N*i*j) + arr(2, j) * cos(PI2_N*i*j); % 计算虚部
            end
        end
    
    elseif(flag == 1) % 反变换
        for i = 1:len2
            for j = 1:len2
                result(1, i) = result(1, i) + arr(1, j) * cos(PI2_N*i*j) - arr(2, j) * sin(PI2_N*i*j); % 计算实部
                result(2, i) = result(2, i) + arr(1, j) * sin(PI2_N*i*j) + arr(2, j) * cos(PI2_N*i*j); % 计算虚部
            end
            result(1, i) = result(1, i) ./ len2;
            result(2, i) = result(2, i) ./ len2;
        end
        
        % 接近0的数字置0
        for i = 1:len1
            for j = 1:len2
                if abs(result(i, j) - round(result(i, j))) < 0.0001 
                    result(i, j) = round(result(i, j));
                end
            end
        end
        
    end
end