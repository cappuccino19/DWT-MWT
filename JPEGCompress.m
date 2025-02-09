function JPEG = JPEGCompress(I)
%图像压缩处理  
%读取图像  
I1=im2double(I);							%图像存储类型转换   
T=dctmtx(8);								%离散余弦变换矩阵   
dct=@(x)T*x*T';							%设置函数句柄
B=blockproc(I1,[8 8],dct);						%对源图像进行DCT变换   
mask=[  1 1 1 1 0 0 0 0
        1 1 1 0 0 0 0 0
        1 1 0 0 0 0 0 0
        1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0];						%掩膜   
B2=blockproc(B,[8 8],@(x)mask.*x);				%图像块处理
invdct=@(x)T'*x*T;
JPEG=blockproc(B2,[8 8],invdct);						%进行DCT反变换 ，得到压缩后的图像  