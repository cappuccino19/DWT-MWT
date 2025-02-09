function ex_mwt_dct_svd1()
clear;


% MWT PARAMETERS: ------------------------------------------------------- %
param.typ = {'GaussianHP'}; % Soulard's fast decaying Gaussian-based wavelets
param.norma = true;   % normalize subbands
param.sampling = 'undec'; % 'undec' or 'pyramid'
param.noRzHF = true; % remove Riesz transform at first scale
% ----------------------------------------------------------------------- %

[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'��ˮӡͼƬ'); %select image
    Imau=imread(strcat(anhmau,fname)); 
    figure(1),imshow(Imau),title('��ˮӡͼƬ');
    %Doc anh mau vao
    Imau = double(imresize(Imau,[512 512],'bilinear'));
        figure(5),imshow(Imau),title('Anh Mau');

    mwt_R1 = mwt_radial( 'a' , Imau(:,:,1) , 3 , param ); % Channelwise MWT
    mwt_G1 = mwt_radial( 'a' , Imau(:,:,2) , 3 , param ); % Channelwise MWT
    mwt_B1 = mwt_radial( 'a' , Imau(:,:,3) , 3 , param ); % Channelwise MWT
    s  = cimg( mwt_R1{3,1} , mwt_G1{3,1} , mwt_B1{3,1} ); % Primary color subband
    sx = cimg( mwt_R1{3,2} , mwt_G1{3,2} , mwt_B1{3,2} ); % Riesz-x color subband
    sy = cimg( mwt_R1{3,3} , mwt_G1{3,3} , mwt_B1{3,3} ); % Riesz-y color subband
  % - Riesz-based structure tensor analysis:
  [n1,lambdaP,coher,ori] = tensor(sx,sy,0.5); 
  clear n1 lambdaP;
  sh = ( sx .* cimg(cos(ori)) + sy .* cimg(sin(ori)) ); % directional RT
  % - Ellipse parameters along local direction:
  [kap,la, phi ,a1,a2,a3] = ellipse3( s , sh );
  DHL = dct2(phi);

  [U1, S1, V1] = svd(DHL);

% 4 band cua anh watermark
    [fname anhgiau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'ԭʼͼƬ'); %select image
    %Doc anh can anh vao
    Igiau=imread(strcat(anhgiau,fname)); 
    figure(2),imshow(Igiau),title('Anh Watermark');
    Igiau = double(imresize(Igiau,[512 512],'bilinear'));
    mwt_R2 = mwt_radial( 'a' , Igiau(:,:,1) , 3 , param ); % Channelwise MWT
    mwt_G2 = mwt_radial( 'a' , Igiau(:,:,2) , 3 , param ); % Channelwise MWT
    mwt_B2 = mwt_radial( 'a' , Igiau(:,:,3) , 3 , param ); % Channelwise MWT  
    s2  = cimg( mwt_R2{3,1} , mwt_G2{3,1} , mwt_B2{3,1} ); % Primary color subband
    sx2 = cimg( mwt_R2{3,2} , mwt_G2{3,2} , mwt_B2{3,2} ); % Riesz-x color subband
    sy2 = cimg( mwt_R2{3,3} , mwt_G2{3,3} , mwt_B2{3,3} ); % Riesz-y color subband
  
  % - Riesz-based structure tensor analysis:
  [n2,lambdaP2,coher2,ori2] = tensor(sx2,sy2,0.5); 
  clear n2 lambdaP2;
  sh2 = ( sx2 .* cimg(cos(ori2)) + sy2 .* cimg(sin(ori2)) ); % directional RT
  % - Ellipse parameters along local direction:
  [kap2,la2, phi2 ,a12,a22,a32] = ellipse3( s2 , sh2 );
  DHL1 = dct2(phi2);
  [UW1, SW1, VW1] = svd(DHL1);
  load Uw.mat UM1
  load Vw.mat VM1
  load la.mat wla
  load kap.mat wkap
  load a1.mat wa1
  load a2.mat wa2
  load a3.mat wa3

% Xu Ly
  SR1 = (S1 - SW1) * 100;

  I1_s11 = UM1 * SR1 * VM1';

  I1_d11 = idct2(I1_s11);

% Ket Qua
  [r,g,b,rh,gh,bh] = ellipse3_back(wkap,wla,I1_d11 ,wa1, wa2,wa3);
  %WaterMarked = cat(6,r,g,b,rh,gh,bh);
  WaterMarked =cimg(r,g,b);
  %WaterMarked = double(imresize(WaterMarked,[512 512],'bilinear'));
  WaterMarked = uint8(WaterMarked);
  %Watermarked_image=cat(3,WaterMarked,Igiau(:,:,2),Igiau(:,:,3)); 
  figure(3); 
  imwrite(WaterMarked,'mwt-w1.bmp','bmp');
  imshow(WaterMarked,[]); title('Watermarke of Image'); 

end

