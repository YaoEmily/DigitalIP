clear;

fileName = 'bird_GT.bmp';
file_image = fopen(fileName, 'r');
image = fread(file_image, inf);
image =  int32(image);
image2 = imread(fileName);

m = bit2int(image, 19, 22);
n = bit2int(image, 23, 26);
digits = bit2int(image, 29, 30);
perLine = ceil((m * 3) / 4) * 4;

if(digits == 24)
    %生成矩阵
    rgb = readImage(image, m, n);
    
    %分别输出RGB图像
    iR = rgb;
    iG = rgb;
    iB = rgb;
    iR(:, :, 2) = 0;
    iR(:, :, 3) = 0;
    iG(:, :, 1) = 0;
    iG(:, :, 3) = 0;
    iB(:, :, 1) = 0;
    iB(:, :, 2) = 0;
    
    figure(1);
    subplot(2, 2, 1); imshow(uint8(rgb)); title('original');
    subplot(2, 2, 2); imshow(uint8(iR)); title('R');
    subplot(2, 2, 3); imshow(uint8(iG)); title('G');
    subplot(2, 2, 4); imshow(uint8(iB)); title('B');
    
    %分别输出YIQHSI
    RGBtoYIQ = [0.299, 0.587, 0.114;
        0.596, -0.274, -0.322;
        0.211, -0.523, 0.312];
    %arrYIQ = 
    tmp1 = rgb(:, :, 1); tmp1 = tmp1(:).';
    tmp2 = rgb(:, :, 2); tmp2 = tmp2(:).';
    tmp3 = rgb(:, :, 3); tmp3 = tmp3(:).';
    result = RGBtoYIQ * [tmp1; tmp2; tmp3];
    iY = reshape(result(1, :), m, n);
    iI = reshape(result(2, :), m, n);
    iQ = reshape(result(3, :), m, n);
    figure(2);
    subplot(2, 2, 1); imshow(uint8(rgb)); title('original');
    subplot(2, 2, 2); imshow(uint8(iY)); title('Y');
    subplot(2, 2, 3); imshow(uint8(iI)); title('I');
    subplot(2, 2, 4); imshow(uint8(iQ)); title('Q');
%     %根据坐标输出RGB
%     tmp1=input('please input the x: ');
%     tmp2=input('please input the y: ');
%     lenth = 54 + ((m-tmp1) * perLine + tmp2 * 3 - 2);
%     B = bit2int(image, lenth, lenth);
%     G = bit2int(image, lenth+1, lenth+1);
%     R = bit2int(image, lenth+2, lenth+2);
%     fprintf('R is %d, G is %d, B is %d.\n', R, G, B);
else
    fprintf('please input 24bit bmp picture.\n');
end

fclose(file_image);