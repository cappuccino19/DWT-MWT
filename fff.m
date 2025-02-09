clear,close all;
A=imread('D:\wuan\code\DWT-MWT1\school.png');
A=rgb2gray(A);

subplot(1,3,1),imshow(A),title('原始图像');
A=double(A)/255;
f=Arnold(A,1);
subplot(1,3,2),imshow(f),title('一次Arnold变换后的图像');
c=Arnold(A,10);
subplot(1,3,3),imshow(c),title('十次Arnold变换后的图像');
