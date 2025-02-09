clear;
YT=imread('D:\wuan\code\DWT-MWT1\school.png'); 
YT=imresize(YT,[512 512],'bilinear');
WT=imread('D:\wuan\code\DWT-MWT1\mwt.bmp');
WT=imresize(WT,[512 512],'bilinear');
[psnr mse]=PSNR(WT,YT);
fprintf('PSNR is %f\n',psnr);
fprintf('MSE is %e\n',mse);