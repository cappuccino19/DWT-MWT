clear;
W1=imread('D:\wuan\code\DWT-MWT1\river.png'); 
%W1=imresize(W1,[512 512],'bilinear');
W1=rgb2gray(W1);
W2=imread('D:\wuan\code\DWT-MWT1\HLJU.png');
%W2=imresize(W2,[512 512],'bilinear');
W2=rgb2gray(W2);
W3=imread('D:\wuan\code\DWT-MWT1\face8.png');
%W3=imresize(W3,[512 512],'bilinear');
W3=rgb2gray(W3);
R1=imread('D:\wuan\code\DWT-MWT1\mwt-w.bmp'); 
%R1=imresize(R1,[512 512],'bilinear');
R1=rgb2gray(R1);
R2=imread('D:\wuan\code\DWT-MWT1\mwt-m.bmp'); 
%R2=imresize(R2,[512 512],'bilinear');
R2=rgb2gray(R2);
R3=imread('D:\wuan\code\DWT-MWT1\mwt-d.bmp'); 
%R3=imresize(R3,[512 512],'bilinear');
R3=rgb2gray(R3);
NC1=NC(W1,R1);
NC2=NC(W2,R2);
NC3=NC(W3,R3);
fprintf('NC1 is %f\n',NC1);
fprintf('NC2 is %f\n',NC2);
fprintf('NC3 is %f\n',NC3);