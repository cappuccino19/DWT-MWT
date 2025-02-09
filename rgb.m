
im=imread('D:\Nepenthe\Code\MWT\school.png');
im_red = im;
im_green = im;
im_blue = im;

% Red channel only
im_red(:,:,2) = 0; 
im_red(:,:,3) = 0; 
figure(1), imshow(im_red);

% Green channel only
im_green(:,:,1) = 0; 
im_green(:,:,3) = 0; 
figure(2), imshow(im_green);

% Blue channel only
im_blue(:,:,1) = 0; 
im_blue(:,:,2) = 0; 
figure(3), imshow(im_blue);
imwrite(im_red,'D:\Nepenthe\学习资料\参考文献\图\R.bmp','bmp');
imwrite(im_green,'D:\Nepenthe\学习资料\参考文献\图\G.bmp','bmp');
imwrite(im_blue,'D:\Nepenthe\学习资料\参考文献\图\B.bmp','bmp');