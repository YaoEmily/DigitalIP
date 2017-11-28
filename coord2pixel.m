function coord2pixel(image, m, n)

    tmp1=input('please input the x: ');
	tmp2=input('please input the y: ');
    
    perLine = ceil((m * 3) / 4) * 4;
    
    lenth = 54 + ((n-tmp1) * perLine + tmp2 * 3 - 2);
    
    %fprintf()
    B = bit2int(image, lenth, lenth);
    G = bit2int(image, lenth+1, lenth+1);
    R = bit2int(image, lenth+2, lenth+2);
    fprintf('R is %d, G is %d, B is %d.\n', R, G, B);

end