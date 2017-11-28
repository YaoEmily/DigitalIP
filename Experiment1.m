clear;

fileName = 'bird_GT2.bmp';
file_image = fopen(fileName, 'r');
image = fread(file_image, inf);
image =  int32(image);
image2 = imread(fileName);

m = bit2int(image, 19, 22);
n = bit2int(image, 23, 26);
digits = bit2int(image, 29, 30);

if(digits == 24)
    %生成矩阵
    rgb = readImage(image, m, n);
    
    %分别输出RGB图像
    [iR, iG, iB] = rgb2RGB(rgb);
    figure(1);
    subplot(2, 2, 1); imshow(uint8(rgb)); title('original');
    subplot(2, 2, 2); imshow(uint8(iR)); title('R');
    subplot(2, 2, 3); imshow(uint8(iG)); title('G');
    subplot(2, 2, 4); imshow(uint8(iB)); title('B');
    
    %分别输出YIQ
    [iY, iI, iQ] = rgb2yiq(rgb, m, n);
    figure(2);
    subplot(2, 2, 1); imshow(uint8(rgb)); title('original');
    subplot(2, 2, 2); imshow(uint8(iY)); title('Y');
    subplot(2, 2, 3); imshow(uint8(iI)); title('I');
    subplot(2, 2, 4); imshow(uint8(iQ)); title('Q');
    
    %分别输出HSI
    [iH, iS, iI2] = rgb2hsi(rgb);
    figure(3);
    subplot(2, 2, 1); imshow(uint8(rgb)); title('original');
    subplot(2, 2, 2); imshow(uint8(iH)); title('H');
    subplot(2, 2, 3); imshow(uint8(iS)); title('S');
    subplot(2, 2, 4); imshow(uint8(iI2)); title('I');
    
    %根据坐标输出RGB
    coord2pixel(image, m, n);
else
    fprintf('please input 24bit bmp picture.\n');
end

fclose(file_image);