clear;

rgb = imread('bird_GT.bmp');
[m, n, k] = size(rgb);
blockSize = 8;
numBlocksM = ceil(m / blockSize);
numBlocksN = ceil(n / blockSize);

% 补全图片长宽为8的倍数
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
figure(1);
subplot(1, 3, 1); imshow(yuv(:,:,1)); title('original');
subplot(1, 3, 2); imshow(dftArr); title('after DFT');
subplot(1, 3, 3); imshow(dftArr2); title('after inverse DFT');

% 每一块做DCT变换
c3 = c1;
c4 = c1;
dctArr = zeros(m, n);
for i = 1:numBlocksM
    for j = 1:numBlocksN
        tmp = myDCT2(c1{i, j}, 0);
        c3{i, j} = tmp;
        dctArr(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = tmp(:,:,1);
    end
end

% 每一块做反DCT变换
dctArr2 = zeros(m, n);
for i = 1:numBlocksM
    for j = 1:numBlocksN
        tmp = myDCT2(c3{i, j}, 1);
        dctArr2(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = tmp(:,:,1);
    end
end

% 输出DCT图像
figure(2);
subplot(1, 3, 1); imshow(yuv(:,:,1)); title('original');
subplot(1, 3, 2); imshow(dctArr); title('after DCT');
subplot(1, 3, 3); imshow(dctArr2); title('after inverse DCT');

% 设置阈值 筛选系数 重构 比较psnr
threshold = [0.001, 0.01, 0.1, 0.5, 1];
for k = 1:5
    dctArr3 = zeros(m, n);
    for i = 1:m
        for j = 1:n
            if abs(dctArr(i, j)) < threshold(k)
                dctArr3(i, j) = 0;
            else
                dctArr3(i, j) = dctArr(i, j);
            end
        end
    end
    dctArr4 = zeros(m, n);
    for i = 1:numBlocksM
        for j = 1:numBlocksN
            tmp = myDCT2(dctArr3(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)), 1);
            dctArr4(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = tmp(:,:,1);
        end
    end
    
    % 输出DCT图像
    figure(k+2);
    subplot(1, 3, 1); imshow(yuv(:,:,1)); title('original');
    subplot(1, 3, 2); imshow(dctArr3); title(num2str(threshold(k)));
    subplot(1, 3, 3); imshow(dctArr4); title(['the psnr is ',num2str(psnr(im2double(yuv(:,:,1)), dctArr4))]);
end

% 输出DCT基图像
m = 8;
n = 8;
mm = 0;
k = zeros(1, m);

k(1) = 1/sqrt(2);
for i = 2:m
    k(i)=1;
end

for i = 0:m-1
    for j = 0:m-1
        for x = 0:m-1
            mm = mm+1;
            for y = 0:n-1
                q(mm,y+1) = 0.5 * k(i+1) * k(j+1) * cos(pi*(2*x+1)*i/(2*m)) * cos(pi*(2*y+1)*j/(2*n));
            end
        end
    end
end

q_min = min(q);
q_max = max(q);
z = -7;

figure;
for i = 1:m*n
    z = z + 8;
    qq = q(z:z+7, 1:8);
    baseImage = mat2gray(qq, [q_min(1), q_max(1)]);
    subplot(m,n,i); imshow(baseImage);
end