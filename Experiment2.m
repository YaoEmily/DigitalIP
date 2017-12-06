clear;

rgb = imread('bird_GT.bmp');
[m, n, k] = size(rgb);
blockSize = 8;
numBlocksM = ceil(m / blockSize);
numBlocksN = ceil(n / blockSize);

% 补全图片像素为8的倍数
if(numBlocksM * blockSize ~= m)
    for i = m+1 : numBlocksM*blockSize
        rgb(i, :, :) = rgb(m, :, :);
    end
    m = numBlocksM * blockSize;
end
if(numBlocksN * blockSize ~= n)
    for j = n+1 : numBlocksN*blockSize
        rgb(:, j, :) = rgb(:, n, :);
    end
    n = numBlocksN * blockSize;
end

% rgb转yuv
[yuv(:,:,1), yuv(:,:,2), yuv(:,:,3)] = rgb2yuv(rgb);

% 8*8分块
c1 = cell(numBlocksM, numBlocksN);
for i = 1:numBlocksM
    for j = 1:numBlocksN
        c1{i, j} = im2double(yuv(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize), 1));
    end
end

% 每一块做DFT变换
c2 = c1;
dftArr = zeros(m, n);
t0 = cputime;
for i = 1:numBlocksM
    for j = 1:numBlocksN
        tmp = myDFT2(c1{i, j}, 0);
        c2{i, j} = tmp;
        dftArr(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = tmp(:,:,1);
    end
end
t1 = cputime - t0;
fprintf('DFT时间为 %fs\n', t1);

% 每一块做反DFT变换
dftArr2 = zeros(m, n);
t0 = cputime;
for i = 1:numBlocksM
    for j = 1:numBlocksN
        tmp = myDFT2(c2{i, j}, 1);
        dftArr2(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = tmp(:,:,1);
    end
end
t2 = cputime - t0;
fprintf('反DFT时间为 %fs\n', t2);

% 输出DFT效果
subplot(1, 3, 1); imshow(yuv(:,:,1)); title('original');
subplot(1, 3, 2); imshow(dftArr); title('after DFT');
subplot(1, 3, 3); imshow(dftArr2); title('after inverse DFT');
