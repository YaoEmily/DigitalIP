function [iR, iG, iB] = rgb2RGB(rgb)

    iR = rgb;
    iG = rgb;
    iB = rgb;
    iR(:, :, 2) = 0;
    iR(:, :, 3) = 0;
    iG(:, :, 1) = 0;
    iG(:, :, 3) = 0;
    iB(:, :, 1) = 0;
    iB(:, :, 2) = 0;

end