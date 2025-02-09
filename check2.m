clear;
% MWT PARAMETERS: ------------------------------------------------------- %
param.typ = {'GaussianHP'}; % Soulard's fast decaying Gaussian-based wavelets
param.norma = true;   % normalize subbands
param.sampling = 'undec'; % 'undec' or 'pyramid'
param.noRzHF = true; % remove Riesz transform at first scale
% ----------------------------------------------------------------------- %  
Imau=imread('D:\wuan\code\DWT-MWT1\school.png'); 
  Imau=double(Imau)/255;
  figure(1),imshow(Imau),title('原始图像');
  s=Imau;
  sh=rand(512,512,3);
 % L=5;
%   Doc anh mau vao
%   mwt_R1 = mwt_radial( 'a' , Imau(:,:,1) , L , param ); % Channelwise MWT
%   mwt_G1 = mwt_radial( 'a' , Imau(:,:,2) , L , param ); % Channelwise MWT
%   mwt_B1 = mwt_radial( 'a' , Imau(:,:,3) , L , param ); % Channelwise MWT
%   s  = cimg( mwt_R1{L,1} , mwt_G1{L,1} , mwt_B1{L,1} ); % Primary color subband
%   sx = cimg( mwt_R1{L,2} , mwt_G1{L,2} , mwt_B1{L,2} ); % Riesz-x color subband
%   sy = cimg( mwt_R1{L,3} , mwt_G1{L,3} , mwt_B1{L,3} ); % Riesz-y color subband
%   [n1,lambdaP,coher,ori] = tensor(sx,sy,0.5);   
%   clear n1 lambdaP;
%   sh = ( sx .* cimg(cos(ori)) + sy .* cimg(sin(ori)) ); % directional RT
  sS1=s(:,:,1);
  sS2=s(:,:,2);
  sS3=s(:,:,3);
%   figure(3),imshow(sh),title('原图sh');
  % - Ellipse parameters along local direction:
  [kap,la,phi,a1,a2,a3] = ellipse31( s , sh );    

  [s1,sh1] = ellipse3_back1(kap,la,phi,a1,a2,a3);
  sS4=s1(:,:,1);
  sS5=s1(:,:,2);
  sS6=s1(:,:,3);
  if sS1==sS4
    fprintf('yes\n');
  else
    ssss=sS1-sS4;
    fprintf('no\n');
  end