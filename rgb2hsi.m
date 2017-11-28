function [iH, iS, iI] = rgb2hsi(rgb)

    rgb = im2double(rgb);  
    r = rgb(:, :, 1);
    g = rgb(:, :, 2);
    b = rgb(:, :, 3);
    
    num = 0.5*((r - g) + (r - b));
    den = sqrt((r - g).^2 + (r - b).*(g - b));
    theta = acos(num./(den + eps));
    
    iI = (r + g + b) / 3;

    iH = theta;
    iH(b > g) = 2*pi - iH(b > g);
    iH = iH/(2*pi);

    num = min(min(r, g), b);
    den = r + g + b;
    den(den == 0) = eps;
    iS = 1 - 3.* num./den;

    iH(iS == 0) = 0;

end