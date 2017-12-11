function SSIM = mySSIM(oriImage, procImage)
    oriImage = double(oriImage);
    procImage = double(procImage);

    ux = mean(mean(oriImage));
    uy = mean(mean(procImage));

    sigma2x=mean(mean((oriImage-ux).^2));
    sigma2y=mean(mean((procImage-uy).^2));   
    sigmaxy=mean(mean((oriImage-ux).*(procImage-uy)));

    k1=0.01;
    k2=0.03;
    L=255;
    c1=(k1*L)^2;
    c2=(k2*L)^2;
    c3=c2/2;

    l = (2*ux*uy+c1)/(ux*ux+uy*uy+c1);
    c = (2*sqrt(sigma2x)*sqrt(sigma2y)+c2)/(sigma2x+sigma2y+c2);
    s = (sigmaxy+c3)/(sqrt(sigma2x)*sqrt(sigma2y)+c3);

    SSIM = l*c*s;
end