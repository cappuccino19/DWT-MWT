function JPEG = JPEGCompress(I)
%ͼ��ѹ������  
%��ȡͼ��  
I1=im2double(I);							%ͼ��洢����ת��   
T=dctmtx(8);								%��ɢ���ұ任����   
dct=@(x)T*x*T';							%���ú������
B=blockproc(I1,[8 8],dct);						%��Դͼ�����DCT�任   
mask=[  1 1 1 1 0 0 0 0
        1 1 1 0 0 0 0 0
        1 1 0 0 0 0 0 0
        1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0];						%��Ĥ   
B2=blockproc(B,[8 8],@(x)mask.*x);				%ͼ��鴦��
invdct=@(x)T'*x*T;
JPEG=blockproc(B2,[8 8],invdct);						%����DCT���任 ���õ�ѹ�����ͼ��  