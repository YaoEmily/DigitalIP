clear;

rgb = imread('bird_GT.bmp');
[m, n, ~] = size(rgb);
rgb = im2double(rgb);
gray = rgb2gray(rgb);

% ���ɸ�˹����ͼ��
mu = 0;
sigma = 1;
gaussianNoise = gray + getGaussianNoiseMatrix(m, n, mu, sigma);
GNpsnr = psnr(gray, gaussianNoise);
GNssim = ssim(gray, gaussianNoise);

% �ӽ�������ͼ��
saltPepperNoise = getSaltPepperNoiseMatrix(gray, 0.01);
SPNpsnr = psnr(gray, saltPepperNoise);
SPNssim = ssim(gray, saltPepperNoise);

% ��ֵ�˲� ��˹����ͼ��
medianFilterGN = medianFilter(gaussianNoise);
MedianF_GNpsnr = psnr(gray, medianFilterGN);
MedianF_GNssim = ssim(gray, medianFilterGN);

% ��ֵ�˲� ��������ͼ��
medianFilterSPN = medianFilter(saltPepperNoise);
MedianF_SPNpsnr = psnr(gray, medianFilterSPN);
MedianF_SPNssim = ssim(gray, medianFilterSPN);

% ��ֵ�˲� ��˹����ͼ��
meanFilterGN = meanFilter(gaussianNoise);
MeanF_GNpsnr = psnr(gray, meanFilterGN);
MeanF_GNssim = ssim(gray, meanFilterGN);

% ��ֵ�˲� ��������ͼ��
meanFilterSPN = meanFilter(saltPepperNoise);
MeanF_SPNpsnr = psnr(gray, meanFilterSPN);
MeanF_SPNssim = ssim(gray, meanFilterSPN);

% ��ʾ��˹����ͼ��
figure(1);
subplot(2, 2, 1); imshow(gray); title('original image');
subplot(2, 2, 2); imshow(gaussianNoise); title(['before filter, psnr = ', num2str(GNpsnr), ', ssim = ', num2str(GNssim)]);
subplot(2, 2, 3); imshow(medianFilterGN); title(['after MedianFilter, psnr = ', num2str(MedianF_GNpsnr), ', ssim = ', num2str(MedianF_GNssim)]);
subplot(2, 2, 4); imshow(meanFilterGN); title(['after MeanFilter, psnr = ', num2str(MeanF_GNpsnr), ', ssim = ', num2str(MeanF_GNssim)]);

% ��ʾ��������ͼ��
figure(2);
subplot(2, 2, 1); imshow(gray); title('original image');
subplot(2, 2, 2); imshow(saltPepperNoise); title(['before filter, psnr = ', num2str(SPNpsnr) ', ssim = ', num2str(SPNssim)]);
subplot(2, 2, 3); imshow(medianFilterSPN); title(['after MedianFilter, psnr = ', num2str(MedianF_SPNpsnr) ', ssim = ', num2str(MedianF_SPNssim)]);
subplot(2, 2, 4); imshow(meanFilterSPN); title(['after MeanFilter, psnr = ', num2str(MeanF_SPNpsnr) ', ssim = ', num2str(MeanF_SPNssim)]);

% С���任ȥ�� ��˹����ͼ��
figure(3);
subplot(2, 2, 1);
imshow(gray);
title('original image');
subplot(2, 2, 2);
imshow(gaussianNoise);
title(['before wavelet transform, psnr is ', num2str(GNpsnr)]);
[c, l]=wavedec2(gaussianNoise, 2, 'coif2');
n = [1,2];
p = [10.28, 10.08];
nc_h = wthcoef2('h', c, l, n, p, 's');
X1 = waverec2(nc_h, l, 'coif2');
subplot(2, 2, 3);
imshow(X1);
title(['after first wavelet transform, psnr is ', num2str(psnr(gray, X1))]);
nc_v=wthcoef2('v',nc_h,l,n,p,'s');
X2=waverec2(nc_v,l,'coif2');
subplot(2, 2, 4);
imshow(X2);
title(['after second wavelet transform, psnr is ', num2str(psnr(gray, X2))]);

% С���任ȥ�� ��������ͼ��
figure(4);
subplot(2, 2, 1);
imshow(gray);
title('original image');
subplot(2, 2, 2);
imshow(saltPepperNoise);
title(['before wavelet transform, psnr is ', num2str(SPNpsnr)]);
[c, l]=wavedec2(saltPepperNoise, 2, 'coif2');
n = [1,2];
p = [10.28, 10.08];
nc_h = wthcoef2('h', c, l, n, p, 's');
X1 = waverec2(nc_h, l, 'coif2');
subplot(2, 2, 3);
imshow(X1);
title(['after first wavelet transform, psnr is ', num2str(psnr(gray, X1))]);
nc_v=wthcoef2('v',nc_h,l,n,p,'s');
X2=waverec2(nc_v,l,'coif2');
subplot(2, 2, 4);
imshow(X2);
title(['after second wavelet transform, psnr is ', num2str(psnr(gray, X2))]);

% sobel��Ե����㷨
mySobel()