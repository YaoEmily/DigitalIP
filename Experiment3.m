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
figure(1);
imshow(gaussianNoise);

% �ӽ�������ͼ��
saltPepperNoise = getSaltPepperNoiseMatrix(gray, 0.01);
SPNpsnr = psnr(gray, saltPepperNoise);
figure(2);
imshow(saltPepperNoise);

% ��ֵ�˲� ��˹����ͼ��
medianFilterGN = medianFilter(gaussianNoise);
MF_GNpsnr = psnr(gray, medianFilterGN);
figure(3);
subplot(1, 2, 1); imshow(gaussianNoise); title(['before MedianFilter, psnr = ', num2str(GNpsnr)]);
subplot(1, 2, 2); imshow(medianFilterGN); title(['after MedianFilter, psnr = ', num2str(MF_GNpsnr)]);

% ��ֵ�˲� ��������ͼ��
medianFilterSPN = medianFilter(saltPepperNoise);
MF_SPNpsnr = psnr(gray, medianFilterSPN);
figure(4);
subplot(1, 2, 1); imshow(saltPepperNoise); title(['before MedianFilter, psnr = ', num2str(SPNpsnr)]);
subplot(1, 2, 2); imshow(medianFilterSPN); title(['after MedianFilter, psnr = ', num2str(MF_SPNpsnr)]);