clear;

rgb = imread('bird_GT.bmp');
[m, n, ~] = size(rgb);
rgb = im2double(rgb);
gray = rgb2gray(rgb);

% Éú³É¸ßË¹ÔëÉùÍ¼Ïñ
mu = 0;
sigma = 1;
gaussianNoise = gray + getGaussianNoiseMatrix(m, n, mu, sigma);
GNpsnr = psnr(gray, gaussianNoise);
GNssim = ssim(gray, gaussianNoise);

% ¼Ó½·ÑÎÔëÉùÍ¼Ïñ
saltPepperNoise = getSaltPepperNoiseMatrix(gray, 0.01);
SPNpsnr = psnr(gray, saltPepperNoise);
SPNssim = ssim(gray, saltPepperNoise);

% ÖĞÖµÂË²¨ ¸ßË¹ÔëÉùÍ¼Ïñ
medianFilterGN = medianFilter(gaussianNoise);
MedianF_GNpsnr = psnr(gray, medianFilterGN);
MedianF_GNssim = ssim(gray, medianFilterGN);

% ÖĞÖµÂË²¨ ½·ÑÎÔëÉùÍ¼Ïñ
medianFilterSPN = medianFilter(saltPepperNoise);
MedianF_SPNpsnr = psnr(gray, medianFilterSPN);
MedianF_SPNssim = ssim(gray, medianFilterSPN);

% ¾ùÖµÂË²¨ ¸ßË¹ÔëÉùÍ¼Ïñ
meanFilterGN = meanFilter(gaussianNoise);
MeanF_GNpsnr = psnr(gray, meanFilterGN);
MeanF_GNssim = ssim(gray, meanFilterGN);

% ¾ùÖµÂË²¨ ½·ÑÎÔëÉùÍ¼Ïñ
meanFilterSPN = meanFilter(saltPepperNoise);
MeanF_SPNpsnr = psnr(gray, meanFilterSPN);
MeanF_SPNssim = ssim(gray, meanFilterSPN);

% ÏÔÊ¾¸ßË¹ÔëÉùÍ¼Ïñ
figure(1);
subplot(2, 2, 1); imshow(gray); title('original image');
subplot(2, 2, 2); imshow(gaussianNoise); title(['before filter, psnr = ', num2str(GNpsnr), ', ssim = ', num2str(GNssim)]);
subplot(2, 2, 3); imshow(medianFilterGN); title(['after MedianFilter, psnr = ', num2str(MedianF_GNpsnr), ', ssim = ', num2str(MedianF_GNssim)]);
subplot(2, 2, 4); imshow(meanFilterGN); title(['after MeanFilter, psnr = ', num2str(MeanF_GNpsnr), ', ssim = ', num2str(MeanF_GNssim)]);

% ÏÔÊ¾½·ÑÎÔëÉùÍ¼Ïñ
figure(2);
subplot(2, 2, 1); imshow(gray); title('original image');
subplot(2, 2, 2); imshow(saltPepperNoise); title(['before filter, psnr = ', num2str(SPNpsnr) ', ssim = ', num2str(SPNssim)]);
subplot(2, 2, 3); imshow(medianFilterSPN); title(['after MedianFilter, psnr = ', num2str(MedianF_SPNpsnr) ', ssim = ', num2str(MedianF_SPNssim)]);
subplot(2, 2, 4); imshow(meanFilterSPN); title(['after MeanFilter, psnr = ', num2str(MeanF_SPNpsnr) ', ssim = ', num2str(MeanF_SPNssim)]);

% Ğ¡²¨±ä»»È¥Ôë ¸ßË¹ÔëÉùÍ¼Ïñ
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

% Ğ¡²¨±ä»»È¥Ôë ½·ÑÎÔëÉùÍ¼Ïñ
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

% sobel±ßÔµ¼ì²âËã·¨
mySobel()