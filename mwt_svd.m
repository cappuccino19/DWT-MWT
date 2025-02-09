close all;
clear;

% Monogenic Wavelet Transform parameters:
param.typ = {'GaussianHP'}; % Fast decaying wavelets from [Soulard IEEE TPAMI 2017]
param.norma = true;        % Subband normalization
param.sampling = 'undec';   % Undecimated design (instead of 'pyramid')
param.noRzHF = true;       % Remove Riesz transform at first scale

    Imau=double(imread('lena.BMP'))/255; 
    figure(1),imshow(Imau),title('原图');
    L=5;
    %Doc anh mau vao
    mwt_R1 = mwt_radial( 'a' , Imau(:,:,1) , L , param ); % Channelwise MWT
    mwt_G1 = mwt_radial( 'a' , Imau(:,:,2) , L , param ); % Channelwise MWT
    mwt_B1 = mwt_radial( 'a' , Imau(:,:,3) , L , param ); % Channelwise MWT
    s  = cimg( mwt_R1{L,1} , mwt_G1{L,1} , mwt_B1{L,1} ); % Primary color subband
    sx = cimg( mwt_R1{L,2} , mwt_G1{L,2} , mwt_B1{L,2} ); % Riesz-x color subband
    sy = cimg( mwt_R1{L,3} , mwt_G1{L,3} , mwt_B1{L,3} ); % Riesz-y color subband
   %figure(2),imshow(s),title('原图s');
    % - Riesz-based structure tensor analysis:
    [n1,lambdaP,coher,ori] = tensor(sx,sy,0.5); 
    clear n1 lambdaP;
    sh = ( sx .* cimg(cos(ori)) + sy .* cimg(sin(ori)) ); % directional RT
    %figure(3),imshow(sh),title('原图sh');
    % - Ellipse parameters along local direction:
    [kap,la,phi,a1,a2,a3] = ellipse31( s , sh );
    %amp = kap*sqrt(2);


% Ghi Anh
    [s1 , sh1]= ellipse3_back1(kap,la,phi,a1, a2, a3);
    %figure(4),imshow(s1),title('重构s1');
    %figure(5),imshow(sh1),title('重构sh1');
    rec_R1{L,1}=s1(:,:,1);
    rec_R1{L,2}=sx(:,:,1);
    rec_R1{L,3}=sy(:,:,1);
    rec_G1{L,1}=s1(:,:,2);
    rec_G1{L,2}=sx(:,:,2);
    rec_G1{L,3}=sy(:,:,2);    
    rec_B1{L,1}=s1(:,:,3);
    rec_B1{L,2}=sx(:,:,3);
    rec_B1{L,3}=sy(:,:,3);
    rec_R1{1,1}=mwt_R1{1,1};
    rec_R1{1,2}=mwt_R1{1,2};
    rec_R1{1,3}=mwt_R1{1,3};
    rec_R1{2,1}=mwt_R1{2,1};
    rec_R1{2,2}=mwt_R1{2,2};
    rec_R1{2,3}=mwt_R1{2,3};
    rec_R1{3,1}=mwt_R1{3,1};
    rec_R1{3,2}=mwt_R1{3,2};
    rec_R1{3,3}=mwt_R1{3,3};
    rec_R1{4,1}=mwt_R1{4,1};
    rec_R1{4,2}=mwt_R1{4,2};
    rec_R1{4,3}=mwt_R1{4,3};
    rec_G1{1,1}=mwt_G1{1,1};
    rec_G1{1,2}=mwt_G1{1,2};
    rec_G1{1,3}=mwt_G1{1,3};
    rec_G1{2,1}=mwt_G1{2,1};
    rec_G1{2,2}=mwt_G1{2,2};
    rec_G1{2,3}=mwt_G1{2,3};
    rec_G1{3,1}=mwt_G1{3,1};
    rec_G1{3,2}=mwt_G1{3,2};
    rec_G1{3,3}=mwt_G1{3,3};
    rec_G1{4,1}=mwt_G1{4,1};
    rec_G1{4,2}=mwt_G1{4,2};
    rec_G1{4,3}=mwt_G1{4,3};
    rec_B1{1,1}=mwt_B1{1,1};
    rec_B1{1,2}=mwt_B1{1,2};
    rec_B1{1,3}=mwt_B1{1,3};
    rec_B1{2,1}=mwt_B1{2,1};
    rec_B1{2,2}=mwt_B1{2,2};
    rec_B1{2,3}=mwt_B1{2,3};
    rec_B1{3,1}=mwt_B1{3,1};
    rec_B1{3,2}=mwt_B1{3,2};
    rec_B1{3,3}=mwt_B1{3,3};
    rec_B1{4,1}=mwt_B1{4,1};
    rec_B1{4,2}=mwt_B1{4,2};
    rec_B1{4,3}=mwt_B1{4,3};
    rec_R1{L+1,1}=mwt_R1{L+1,1};
    rec_G1{L+1,1}=mwt_G1{L+1,1};
    rec_B1{L+1,1}=mwt_B1{L+1,1};
    rec_R11 = mwt_radial( 's' , rec_R1 , L , param ); 
    rec_G11 = mwt_radial( 's' , rec_G1 , L , param ); 
    rec_B11 = mwt_radial( 's' , rec_B1 , L , param ); 
    rec=cimg(rec_R11,rec_G11,rec_B11);
    figure(6),imshow(rec),title('重构图片');