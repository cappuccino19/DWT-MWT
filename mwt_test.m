clear;
tic;
% MWT PARAMETERS: ------------------------------------------------------- %
param.typ = {'GaussianHP'}; % Soulard's fast decaying Gaussian-based wavelets
param.norma = true;   % normalize subbands
param.sampling = 'undec'; % 'undec' or 'pyramid'
param.noRzHF = true; % remove Riesz transform at first scale
% ----------------------------------------------------------------------- %
  rand('state',1);
  Imau=imread('D:\wuan\code\DWT-MWT1\school.png'); 
  orig=Imau;
  save original.mat orig
  Imau=double(Imau)/255;
  figure(1),imshow(Imau),title('原始图像');
%   L=5;
%   %Doc anh mau vao
%   mwt_R1 = mwt_radial( 'a' , Imau(:,:,1) , L , param ); % Channelwise MWT
%   mwt_G1 = mwt_radial( 'a' , Imau(:,:,2) , L , param ); % Channelwise MWT
%   mwt_B1 = mwt_radial( 'a' , Imau(:,:,3) , L , param ); % Channelwise MWT
%   s  = cimg( mwt_R1{L,1} , mwt_G1{L,1} , mwt_B1{L,1} ); % Primary color subband
%   sx = cimg( mwt_R1{L,2} , mwt_G1{L,2} , mwt_B1{L,2} ); % Riesz-x color subband
%   sy = cimg( mwt_R1{L,3} , mwt_G1{L,3} , mwt_B1{L,3} ); % Riesz-y color subband
%   [n1,lambdaP,coher,ori] = tensor(sx,sy,0.5);   
%   clear n1 lambdaP;
%   sh = ( sx .* cimg(cos(ori)) + sy .* cimg(sin(ori)) ); % directional RT
%   sS1=s(:,:,1);
%   sS2=s(:,:,2);
%   sS3=s(:,:,3);
  %figure(3),imshow(sh),title('原图sh');
  % - Ellipse parameters along local direction:
  s=Imau;
  sh=rand([512 512 3]);
  save sho.mat sh
  [kap,la,phi,a1,a2,a3] = ellipse31( s , sh );    
    %Doc anh can anh vao
  I2=imread('D:\wuan\code\DWT-MWT1\river.png');
  I2=double(I2)/255;
  figure(2),imshow(I2),title('Watermark1');
%   mwt_R2 = mwt_radial( 'a' , I2(:,:,1) , L , param ); % Channelwise MWT
%   mwt_G2 = mwt_radial( 'a' , I2(:,:,2) , L , param ); % Channelwise MWT
%   mwt_B2 = mwt_radial( 'a' , I2(:,:,3) , L , param ); % Channelwise MWT
%   s2  = cimg( mwt_R2{L,1} , mwt_G2{L,1} , mwt_B2{L,1} ); % Primary color subband
%   sx2 = cimg( mwt_R2{L,2} , mwt_G2{L,2} , mwt_B2{L,2} ); % Riesz-x color subband
%   sy2 = cimg( mwt_R2{L,3} , mwt_G2{L,3} , mwt_B2{L,3} ); % Riesz-y color subband
%   sav_R2=mwt_R2;
%   sav_G2=mwt_G2;
%   sav_B2=mwt_B2;
%   sav_R2{L,1}=0;
%   sav_G2{L,1}=0;
%   sav_B2{L,1}=0;
%   sav_R21 = mwt_radial( 's' , sav_R2 , L , param ); 
%   sav_G21 = mwt_radial( 's' , sav_G2 , L , param ); 
%   sav_B21 = mwt_radial( 's' , sav_B2 , L , param ); 
%   %sav1=cimg(sav_R21,sav_G21,sav_B21);
%   %sav1=double(imresize(sav1,[256 256],'bilinear'));
%   %sav_R21=sav1(:,:,1);
%   %sav_G21=sav1(:,:,2);
%   %sav_B21=sav1(:,:,3);
%   [SR1LL,SR1HL,SR1LH,SR1HH] = dwt2(sav_R21,'haar');
%   Dsav_R21 = dct2(SR1LL);
%   save SR1HL.mat SR1HL
%   save SR1LH.mat SR1LH
%   save SR1HH.mat SR1HH
%   [SG1LL,SG1HL,SG1LH,SG1HH] = dwt2(sav_G21,'haar');
%   Dsav_G21 = dct2(SG1LL);
%   save SG1HL.mat SG1HL
%   save SG1LH.mat SG1LH
%   save SG1HH.mat SG1HH
%   [SB1LL,SB1HL,SB1LH,SB1HH] = dwt2(sav_B21,'haar');
%   Dsav_B21 = dct2(SB1LL);
%   save SB1HL.mat SB1HL
%   save SB1LH.mat SB1LH
%   save SB1HH.mat SB1HH
%   [SU11, SS11, SV11] = svd(Dsav_R21);
%   [SU12, SS12, SV12] = svd(Dsav_G21);
%   [SU13, SS13, SV13] = svd(Dsav_B21);
%   
%   %save SS11I.mat SS11
%   %save SS12I.mat SS12
%   %save SS13I.mat SS13
%   save SU11.mat SU11
%   save SU12.mat SU12
%   save SU13.mat SU13
%   save SV11.mat SV11
%   save SV12.mat SV12
%   save SV13.mat SV13
% %   [SS11,SS11I]=sort(SS11);
% %   save SS11I.mat SS11I
% %   [SS12,SS12I]=sort(SS12);
% %   save SS12I.mat SS12I
% %   [SS13,SS13I]=sort(SS13);
% %   save SS13I.mat SS13I
%   %save sx2.mat sx2
%   %save sy2.mat sy2
%   % - Riesz-based structure tensor analysis:
%   [n2,lambdaP2,coher2,ori2] = tensor(sx2,sy2,0.5); 
%   clear n2 lambdaP2;
%   sh2 = ( sx2 .* cimg(cos(ori2)) + sy2 .* cimg(sin(ori2)) ); % directional RT
  % - Ellipse parameters along local direction:
  s2=I2;
  %sh2=rand([512 512 3]);
  [wkap,wla, wphi ,wa1,wa2,wa3] = ellipse31( s2 , sh );
  %save MWT21.mat mwt_R2
  %save MWT22.mat mwt_G2
  %save MWT23.mat mwt_B2
  save wla.mat wla
  save wphi.mat wphi
  save wa1.mat wa1
  save wa2.mat wa2
  save wa3.mat wa3

  [apLL,apHL,apLH,apHH] = dwt2(kap,'haar');
  APLL = dct2(apLL);
  APHL = dct2(apHL);
  APLH = dct2(apLH);
  APHH = dct2(apHH);
  [U1, S1, V1] = svd(APLL);
%   [S1,S1I]=sort(S1);
%   save S1I.mat S1I
%   [UHL1, SHL1, VHL1] = svd(APHL);
%   [ULH1, SLH1, VLH1] = svd(APLH);
%   [UHH1, SHH1, VHH1] = svd(APHH);
%   [SHL1,SHL1I]=sort(SHL1);
%   save SHL1I.mat SHL1I
%   [SLH1,SLH1I]=sort(SLH1);
%   save SLH1I.mat SLH1I
%   [SHH1,SHH1I]=sort(SHH1);
%   save SHH1I.mat SHH1I
%   save UHL1.mat UHL1
%   save VHL1.mat VHL1
%   save ULH1.mat ULH1
%   save VLH1.mat VLH1
%   save UHH1.mat UHH1
%   save VHH1.mat VHH1
%   SW11=SHL1+0.1 * SS11;
%   SW12=SLH1+0.1 * SS12;
%   SW13=SHH1+0.1 * SS13;
%   [SW11,SW11I]=sort(SW11);
%   save SW11I.mat SW11I
%   [SW12,SW12I]=sort(SW12);
%   save SW12I.mat SW12I
%   [SW13,SW13I]=sort(SW13);
%   save SW13I.mat SW13I
%   IS1_s1= UHL1 * SW11 * VHL1';
%   IS1_s2= ULH1 * SW12 * VLH1';
%   IS1_s3= UHH1 * SW13 * VHH1';
%   IS1_d1=idct2(IS1_s1);
%   IS1_d2=idct2(IS1_s2);
%   IS1_d3=idct2(IS1_s3);
  %WAP = dct2(wkap);
  [aLL,aHL,aLH,aHH] = dwt2(wkap,'haar');
  ALL = dct2(aLL);
  AHL = dct2(aHL);
  ALH = dct2(aLH);
  AHH = dct2(aHH);
  [UM1, SM1, VM1] = svd(ALL);
  test4=SM1;
  %save SM1I.mat SM1
%   [SM1,SM1I]=sort(SM1);
%   test1=SM1;
%   save SM1I.mat SM1I
  save Uw.mat UM1
  save Vw.mat VM1
  save AHL.mat aHL
  save ALH.mat aLH
  save AHH.mat aHH
% Xu Ly
  SC1 = S1 + 0.04 * SM1;
%   [SC1,SC1I]=sort(SC1);
%   save SC1I.mat SC1I
  I3=imread('D:\wuan\code\DWT-MWT1\HLJU.png');
  I3=double(I3)/255;
  figure(3),imshow(I3),title('Watermark2');
  %key=unidrnd(9,512,512);
  f=fft2(S1);
  key=angle(f);
  rad=rand(256);
  for i=1:256
      for j=1:256
          if key(i,j)<0
              key(i,j)=key(i,j)+pi;
          end
          key(i,j)=key(i,j)+rad(i,j);
          key(i,j)=key(i,j)*10;
          key(i,j)=round(key(i,j)); 
      end
  end
  I31=Arnold(I3(:,:,1),key);
  I32=Arnold(I3(:,:,2),key);   
  I33=Arnold(I3(:,:,3),key);
  save Key.mat key
  I3A(:,:,1)=I31;
  I3A(:,:,2)=I32;
  I3A(:,:,3)=I33;
  s3=I3A;
  %sh3=rand([512 512 3]);
%   mwt_R3 = mwt_radial( 'a' , I31 , L , param ); % Channelwise MWT
%   mwt_G3 = mwt_radial( 'a' , I32 , L , param ); % Channelwise MWT
%   mwt_B3 = mwt_radial( 'a' , I33 , L , param ); % Channelwise MWT
%   s3  = cimg( mwt_R3{L,1} , mwt_G3{L,1} , mwt_B3{L,1} ); % Primary color subband
%   sx3 = cimg( mwt_R3{L,2} , mwt_G3{L,2} , mwt_B3{L,2} ); % Riesz-x color subband
%   sy3 = cimg( mwt_R3{L,3} , mwt_G3{L,3} , mwt_B3{L,3} ); % Riesz-y color subband 
%   sav_R3=mwt_R3;
%   sav_G3=mwt_G3;
%   sav_B3=mwt_B3;
%   sav_R3{L,1}=0;
%   sav_G3{L,1}=0;
%   sav_B3{L,1}=0;
%   sav_R31 = mwt_radial( 's' , sav_R3 , L , param ); 
%   sav_G31 = mwt_radial( 's' , sav_G3 , L , param ); 
%   sav_B31 = mwt_radial( 's' , sav_B3 , L , param ); 
%   [SR2LL,SR2HL,SR2LH,SR2HH] = dwt2(sav_R31,'haar');
%   Dsav_R31 = dct2(SR2LL);
%   save SR2HL.mat SR2HL
%   save SR2LH.mat SR2LH
%   save SR2HH.mat SR2HH
%   [SG2LL,SG2HL,SG2LH,SG2HH] = dwt2(sav_G31,'haar');
%   Dsav_G31 = dct2(SG2LL);
%   save SG2HL.mat SG2HL
%   save SG2LH.mat SG2LH
%   save SG2HH.mat SG2HH
%   [SB2LL,SB2HL,SB2LH,SB2HH] = dwt2(sav_B31,'haar');
%   Dsav_B31 = dct2(SB2LL);
%   save SB2HL.mat SB2HL
%   save SB2LH.mat SB2LH
%   save SB2HH.mat SB2HH
%   [SU21, SS21, SV21] = svd(Dsav_R31);
%   [SU22, SS22, SV22] = svd(Dsav_G31);
%   [SU23, SS23, SV23] = svd(Dsav_B31);
%   save SU21.mat SU21
%   save SU22.mat SU22
%   save SU23.mat SU23
%   save SV21.mat SV21
%   save SV22.mat SV22
%   save SV23.mat SV23
%   [SS21,SS21I]=sort(SS21);
%   save SS21I.mat SS21I
%   [SS22,SS22I]=sort(SS22);
%   save SS22I.mat SS22I
%   [SS23,SS23I]=sort(SS23);
%   save SS23I.mat SS23I
  %save sx3.mat sx3
  %save sy3.mat sy3
  % - Riesz-based structure tensor analysis:
%   [n3,lambdaP3,coher3,ori3] = tensor(sx3,sy3,0.5); 
%   clear n3 lambdaP3;
%   sh3 = ( sx3 .* cimg(cos(ori3)) + sy3 .* cimg(sin(ori3)) ); % directional RT
  % - Ellipse parameters along local direction:
  [mkap,mla, mphi ,ma1,ma2,ma3] = ellipse31( s3 , sh );  
%   save MWT31.mat mwt_R3
%   save MWT32.mat mwt_G3
%   save MWT33.mat mwt_B3
  save mkap.mat mkap
  save mla.mat mla
  save ma1.mat ma1
  save ma2.mat ma2
  save ma3.mat ma3
  
  [mpLL,mpHL,mpLH,mpHH] = dwt2(phi,'haar');
  MPLL = dct2(mpLL);
  MPHL = dct2(mpHL);
  MPLH = dct2(mpLH);
  MPHH = dct2(mpHH);
  [U2, S2, V2] = svd(MPLL);
%   [UHL2, SHL2, VHL2] = svd(MPHL);
%   [ULH2, SLH2, VLH2] = svd(MPLH);
%   [UHH2, SHH2, VHH2] = svd(MPHH);
%   [S2,S2I]=sort(S2);
%   save S2I.mat S2I
%   [SHL2,SHL2I]=sort(SHL2);
%   save SHL2I.mat SHL2I
%   [SLH2,SLH2I]=sort(SLH2);
%   save SLH2I.mat SLH2I
%   [SHH2,SHH2I]=sort(SHH2);
%   save SHH2I.mat SHH2I
%   save UHL2.mat UHL2
%   save VHL2.mat VHL2
%   save ULH2.mat ULH2
%   save VLH2.mat VLH2
%   save UHH2.mat UHH2
%   save VHH2.mat VHH2
%   SW21=SHL2+0.1 * SS21;
%   SW22=SLH2+0.1 * SS22;
%   SW23=SHH2+0.1 * SS23;
%   [SW21,SW21I]=sort(SW21);
%   save SW21I.mat SW21I
%   [SW22,SW22I]=sort(SW22);
%   save SW22I.mat SW22I
%   [SW23,SW23I]=sort(SW23);
%   save SW23I.mat SW23I
%   IS2_s1= UHL2 * SW21 * VHL2';
%   IS2_s2= ULH2 * SW22 * VLH2';
%   IS2_s3= UHH2 * SW23 * VHH2';
%   IS2_d1=idct2(IS2_s1);
%   IS2_d2=idct2(IS2_s2);
%   IS2_d3=idct2(IS2_s3);
  [pLL,pHL,pLH,pHH] = dwt2(mphi,'haar');
  PLL = dct2(pLL);
  PHL = dct2(pHL);
  PLH = dct2(pLH);
  PHH = dct2(pHH);
  %WPHI = dct2(mphi);
  [UM2, SM2, VM2] = svd(PLL);
%   save SM2I.mat SM2
%   [SM2,SM2I]=sort(SM2);
%   save SM2I.mat SM2I
  save Um.mat UM2
  save Vm.mat VM2
  save PHL.mat pHL
  save PLH.mat pLH
  save PHH.mat pHH
% Xu Ly
  SC2 = S2 + 0.05 * SM2;
%   [SC2,SC2I]=sort(SC2);
%   save SC2I.mat SC2I
  I4=imread('D:\wuan\code\DWT-MWT1\face8.png');
  I4=double(I4)/255;
  figure(4),imshow(I4),title('Watermark3');
  I41=Arnold(I4(:,:,1),key);
  I42=Arnold(I4(:,:,2),key);   
  I43=Arnold(I4(:,:,3),key);
  I4A(:,:,1)=I41;
  I4A(:,:,2)=I42;
  I4A(:,:,3)=I43;
%   ni1 = [16,8,32,64,32,16,32,8,16,32];
%   ni2 = [8,8,16,16,32,32,64,8,16,32,16,8];
%   ni3 = [16,32,16,8,16,64,32,8,32,8,8,16];
%   alpha =3.8;
%   N1 =10;
%   Nn=[256 256];
%   [C,K] = encryptionf(I4, ni1 , ni2, ni3, N1, N1, N1, Nn, alpha);
%   s4=C;
%   save key2.mat K
%   save ni1.mat ni1
%   save ni2.mat ni2
%   save ni3.mat ni3
%   save N1.mat N1
%   save Nn.mat Nn
%   save alpha.mat alpha
  s4=I4A;
 % sh4=rand([512 512 3]);
%   mwt_R4 = mwt_radial( 'a' , I41 , L , param ); % Channelwise MWT
%   mwt_G4 = mwt_radial( 'a' , I42 , L , param ); % Channelwise MWT
%   mwt_B4 = mwt_radial( 'a' , I43 , L , param ); % Channelwise MWT
%   s4  = cimg( mwt_R4{L,1} , mwt_G4{L,1} , mwt_B4{L,1} ); % Primary color subband
%   sx4 = cimg( mwt_R4{L,2} , mwt_G4{L,2} , mwt_B4{L,2} ); % Riesz-x color subband
%   sy4 = cimg( mwt_R4{L,3} , mwt_G4{L,3} , mwt_B4{L,3} ); % Riesz-y color subband
%   sav_R4=mwt_R4;
%   sav_G4=mwt_G4;
%   sav_B4=mwt_B4;
%   sav_R4{L,1}=0;
%   sav_G4{L,1}=0;
%   sav_B4{L,1}=0;
%   sav_R41 = mwt_radial( 's' , sav_R4 , L , param ); 
%   sav_G41 = mwt_radial( 's' , sav_G4 , L , param ); 
%   sav_B41 = mwt_radial( 's' , sav_B4 , L , param ); 
%   [SR3LL,SR3HL,SR3LH,SR3HH] = dwt2(sav_R41,'haar');
%   Dsav_R41 = dct2(SR3LL);
%   save SR3HL.mat SR3HL
%   save SR3LH.mat SR3LH
%   save SR3HH.mat SR3HH
%   [SG3LL,SG3HL,SG3LH,SG3HH] = dwt2(sav_G41,'haar');
%   Dsav_G41 = dct2(SG3LL);
%   save SG3HL.mat SG3HL
%   save SG3LH.mat SG3LH
%   save SG3HH.mat SG3HH
%   [SB3LL,SB3HL,SB3LH,SB3HH] = dwt2(sav_B41,'haar');
%   Dsav_B41 = dct2(SB1LL);
%   save SB3HL.mat SB3HL
%   save SB3LH.mat SB3LH
%   save SB3HH.mat SB3HH
%   [SU31, SS31, SV31] = svd(Dsav_R41);
%   [SU32, SS32, SV32] = svd(Dsav_G41);
%   [SU33, SS33, SV33] = svd(Dsav_B41);
%   save SU31.mat SU31
%   save SU32.mat SU32
%   save SU33.mat SU33
%   save SV31.mat SV31
%   save SV32.mat SV32
%   save SV33.mat SV33
%   [SS31,SS31I]=sort(SS31);
%   save SS31I.mat SS31I
%   [SS32,SS32I]=sort(SS32);
%   save SS32I.mat SS32I
%   [SS33,SS33I]=sort(SS33);
%   save SS33I.mat SS33I
%   save sx4.mat sx4
%   save sy4.mat sy4
%   % - Riesz-based structure tensor analysis:
%   [n4,lambdaP4,coher4,ori4] = tensor(sx4,sy4,0.5); 
%   clear n4 lambdaP4;
%   sh4 = ( sx4 .* cimg(cos(ori4)) + sy4 .* cimg(sin(ori4)) ); % directional RT
%   % - Ellipse parameters along local direction:
  [dkap,dla, dphi ,da1,da2,da3] = ellipse31( s4 , sh );
%   save MWT41.mat mwt_R4
%   save MWT42.mat mwt_G4
%   save MWT43.mat mwt_B4
  save dkap.mat dkap
  save dphi.mat dphi
  save da1.mat da1
  save da2.mat da2
  save da3.mat da3

  [laLL,laHL,laLH,laHH] = dwt2(la,'haar');
  LALL = dct2(laLL);
  LAHL = dct2(laHL);
  LALH = dct2(laLH);
  LAHH = dct2(laHH);
  %AP = dct2(HH);
  [U3, S3, V3] = svd(LALL);
  %WAP = dct2(wkap);
%   [UHL3, SHL3, VHL3] = svd(MPHL);
%   [ULH3, SLH3, VLH3] = svd(MPLH);
%   [UHH3, SHH3, VHH3] = svd(MPHH);
%   [S3,S3I]=sort(S3);
%   save S3I.mat S3I
%   [SHL3,SHL3I]=sort(SHL3);
%   save SHL3I.mat SHL3I
%   [SLH3,SLH3I]=sort(SLH3);
%   save SLH3I.mat SLH3I
%   [SHH3,SHH3I]=sort(SHH3);
%   save SHH3I.mat SHH3I
%   save UHL3.mat UHL3
%   save VHL3.mat VHL3
%   save ULH3.mat ULH3
%   save VLH3.mat VLH3
%   save UHH3.mat UHH3
%   save VHH3.mat VHH3
%   SW31=SHL3+0.1 * SS31;
%   SW32=SLH3+0.1 * SS32;
%   SW33=SHH3+0.1 * SS33;
%   [SW31,SW31I]=sort(SW31);
%   save SW31I.mat SW31I
%   [SW32,SW32I]=sort(SW32);
%   save SW32I.mat SW32I
%   [SW33,SW33I]=sort(SW33);
%   save SW33I.mat SW33I
%   IS3_s1= UHL3 * SW31 * VHL3';
%   IS3_s2= ULH3 * SW32 * VLH3';
%   IS3_s3= UHH3 * SW33 * VHH3';
%   IS3_d1=idct2(IS3_s1);
%   IS3_d2=idct2(IS3_s2);
%   IS3_d3=idct2(IS3_s3);
  [dLL,dHL,dLH,dHH] = dwt2(dla,'haar');
  DLL = dct2(dLL);
  DHL = dct2(dHL);
  DLH = dct2(dLH);
  DHH = dct2(dHH);
  [UM3, SM3, VM3] = svd(DLL);
%   save SM3I.mat SM3
%   [SM3,SM3I]=sort(SM3);
%   save SM3I.mat SM3I
  save Ud.mat UM3
  save Vd.mat VM3
  save DHL.mat dHL
  save DLH.mat dLH
  save DHH.mat dHH
% Xu Ly
  SC3 = S3 + 0.01 * SM3;
%   [SC3,SC3I]=sort(SC3);
%   save SC3I.mat SC3I
  I1_s1 = U1 * SC1 * V1';
  I1_s2 = U2 * SC2 * V2';
  I1_s3 = U3 * SC3 * V3'; 
  I1_d1 = idct2(I1_s1);
  I1_d1 = idwt2(I1_d1,apHL,apLH,apHH, 'haar', [512,512]);
  I1_d2 = idct2(I1_s2);
  I1_d2 = idwt2(I1_d2,mpHL,mpLH,mpHH, 'haar', [512,512]);
  I1_d3 = idct2(I1_s3);
  I1_d3 = idwt2(I1_d3,laHL,laLH,laHH, 'haar', [512,512]);
% Ghi Anh
   [s1 , sh1]= ellipse3_back1(I1_d1,I1_d3,I1_d2,a1, a2, a3);
  sh11=sh1(:,:,1);
  sh12=sh1(:,:,2);
  sh13=sh1(:,:,3);
   rec=s1;
   save sh1.mat sh1
    %figure(4),imshow(s1),title('重构s1');
    %figure(5),imshow(sh1),title('重构sh1');
%     rec_R1{L,1}=s1(:,:,1);
%     rec_R1{L,2}=sx(:,:,1);
%     rec_R1{L,3}=sy(:,:,1);
%     rec_G1{L,1}=s1(:,:,2);
%     rec_G1{L,2}=sx(:,:,2);
%     rec_G1{L,3}=sy(:,:,2); 
%     rec_B1{L,1}=s1(:,:,3);
%     rec_B1{L,2}=sx(:,:,3);
%     rec_B1{L,3}=sy(:,:,3);
%     rec_R1{1,1}=mwt_R1{1,1};
%     rec_R1{1,2}=mwt_R1{1,2};
%     rec_R1{1,3}=mwt_R1{1,3};
%     rec_R1{2,1}=mwt_R1{2,1};
%     rec_R1{2,2}=mwt_R1{2,2};
%     rec_R1{2,3}=mwt_R1{2,3};
%     rec_R1{3,1}=mwt_R1{3,1};
%     rec_R1{3,2}=mwt_R1{3,2};
%     rec_R1{3,3}=mwt_R1{3,3};
%     rec_R1{4,1}=mwt_R1{4,1};
%     rec_R1{4,2}=mwt_R1{4,2};
%     rec_R1{4,3}=mwt_R1{4,3};
%     rec_G1{1,1}=mwt_G1{1,1};
%     rec_G1{1,2}=mwt_G1{1,2};
%     rec_G1{1,3}=mwt_G1{1,3};
%     rec_G1{2,1}=mwt_G1{2,1};
%     rec_G1{2,2}=mwt_G1{2,2};
%     rec_G1{2,3}=mwt_G1{2,3};
%     rec_G1{3,1}=mwt_G1{3,1};
%     rec_G1{3,2}=mwt_G1{3,2};
%     rec_G1{3,3}=mwt_G1{3,3};
%     rec_G1{4,1}=mwt_G1{4,1};
%     rec_G1{4,2}=mwt_G1{4,2};
%     rec_G1{4,3}=mwt_G1{4,3};
%     rec_B1{1,1}=mwt_B1{1,1};
%     rec_B1{1,2}=mwt_B1{1,2};
%     rec_B1{1,3}=mwt_B1{1,3};
%     rec_B1{2,1}=mwt_B1{2,1};
%     rec_B1{2,2}=mwt_B1{2,2};
%     rec_B1{2,3}=mwt_B1{2,3};
%     rec_B1{3,1}=mwt_B1{3,1};
%     rec_B1{3,2}=mwt_B1{3,2};
%     rec_B1{3,3}=mwt_B1{3,3};
%     rec_B1{4,1}=mwt_B1{4,1};
%     rec_B1{4,2}=mwt_B1{4,2};
%     rec_B1{4,3}=mwt_B1{4,3};
%     rec_R1{L+1,1}=mwt_R1{L+1,1};
%     rec_G1{L+1,1}=mwt_G1{L+1,1};
%     rec_B1{L+1,1}=mwt_B1{L+1,1};
%     rec_R11 = mwt_radial( 's' , rec_R1 , L , param ); 
%     rec_G11 = mwt_radial( 's' , rec_G1 , L , param ); 
%     rec_B11 = mwt_radial( 's' , rec_B1 , L , param ); 
%     %rec=cimg(rec_R11,rec_G11,rec_B11);
%     rec(:,:,1)=rec_R11;
%     rec(:,:,2)=rec_G11;
%     rec(:,:,3)=rec_B11;
    
%     save testnum1.mat test1
%     save testnum4.mat test4
    %rec=noiseAttack(rec);
    rec=gnoiseAttack(rec);
    %rec=meanAttack(rec);
    %rec=medianAttack(rec);
    rec=rotationAttack(rec,90);
    %rec=cropAttack(rec);
    %rec=sprotAttack(rec);
    %rec=imcrop(rec, [0,0,443,443]);
    %imwrite(rec,'D:\wuan\code\DWT-MWT1\mwt.jpg','quality',10);
    save rec.mat rec
    imwrite(rec,'D:\wuan\code\DWT-MWT1\mwt.bmp','bmp');
    figure(5);imshow(rec);title('含水印图像');
    toc;