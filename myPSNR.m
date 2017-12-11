function [PSNR] = myPSNR(oriImage, procImage)
    [m, n] = size(oriImage);
    [m1, n1] = size(procImage);
    oriImage = im2uint8(oriImage);
    procImage = im2uint8(procImage);
    B = 8;
    MAX = 2^B - 1;
    if m~=m1 || n~=n1
        fprintf('There is something wrong.\n');
    else
        MES = sum(sum((oriImage - procImage).^2)) / (m*n);
        PSNR = 20 * log10(MAX / sqrt(MES));
    end
end