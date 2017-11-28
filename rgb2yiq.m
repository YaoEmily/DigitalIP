function [iY, iI, iQ] = rgb2yiq(rgb, m, n)

    RGBtoYIQ = [0.299, 0.587, 0.114;
        0.596, -0.274, -0.322;
        0.211, -0.523, 0.312];
    
    tmp1 = rgb(:, :, 1); tmp1 = tmp1(:).';
    tmp2 = rgb(:, :, 2); tmp2 = tmp2(:).';
    tmp3 = rgb(:, :, 3); tmp3 = tmp3(:).';
    result = RGBtoYIQ * [tmp1; tmp2; tmp3];
    iY = reshape(result(1, :), m, n);
    iI = reshape(result(2, :), m, n);
    iQ = reshape(result(3, :), m, n);

end