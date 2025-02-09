clear;
tic;

% MWT PARAMETERS: ------------------------------------------------------- %
param.typ = {'GaussianHP'}; % Soulard's fast decaying Gaussian-based wavelets
param.norma = true;   % normalize subbands
param.sampling = 'undec'; % 'undec' or 'pyramid'
param.noRzHF = true; % remove Riesz transform at first scale
% ----------------------------------------------------------------------- %
%     L=5;
    rec=imread('D:\wuan\code\DWT-MWT1\mwt.bmp');
    %rec=imread('D:\wuan\code\DWT-MWT1\mwt.jpg');
    %rec=imread('D:\wuan\code\DWT-MWT1\上传下载后的图.bmp');
    rec=double(rec)/255;
    %load rec.mat rec
    rec=imresize(rec,[512 512],'bilinear');
    figure(4),imshow(rec),title('含水印图片');
    sx=rec;
    %Doc anh mau vao
%     mwt_RH = mwt_radial( 'a' , Imau(:,:,1) , L , param ); % Channelwise MWT
%     mwt_GH = mwt_radial( 'a' , Imau(:,:,2) , L , param ); % Channelwise MWT
%     mwt_BH = mwt_radial( 'a' , Imau(:,:,3) , L , param ); % Channelwise MWT
%     s  = cimg( mwt_RH{L,1} , mwt_GH{L,1} , mwt_BH{L,1} ); % Primary color subband
%     sx = cimg( mwt_RH{L,2} , mwt_GH{L,2} , mwt_BH{L,2} ); % Riesz-x color subband
%     sy = cimg( mwt_RH{L,3} , mwt_GH{L,3} , mwt_BH{L,3} ); % Riesz-y color subband
%   % - Riesz-based structure tensor analysis:
%   [n1,lambdaP,coher,ori] = tensor(sx,sy,0.5); 
%   clear n1 lambdaP;
%   sh = ( sx .* cimg(cos(ori)) + sy .* cimg(sin(ori)) ); % directional RT
  % - Ellipse parameters along local direction:
  load sh1.mat sh1
  load sho.mat sh
  %shx=rand([512 512 3]);
  %sh=sh1;
  shx=sh1;
  [kap,la, phi ,a1,a2,a3] = ellipse31( sx , shx );
  [apLL,apHL,apLH,apHH] = dwt2(kap,'haar');
  APLL = dct2(apLL);
  APHL = dct2(apHL);
  APLH = dct2(apLH);
  APHH = dct2(apHH);
  [U1, S1, V1] = svd(APLL);
%   [UHL1, SHL1, VHL1] = svd(APHL);
%   [ULH1, SLH1, VLH1] = svd(APLH);
%   [UHH1, SHH1, VHH1] = svd(APHH);
%   load SC1I.mat SC1I
%   S1=sort(S1);
%   S1=S1(SC1I);
%   load SW11I.mat SW11I
%   SHL1=sort(SHL1);
%   SHL1=SHL1(SW11I);
%   load SW12I.mat SW12I
%   SLH1=sort(SLH1);
%   SLH1=SLH1(SW12I);
%   load SW13I.mat SW13I
%   SHH1=sort(SHH1);
%   SHH1=SHH1(SW13I);
  [mpLL,mpHL,mpLH,mpHH] = dwt2(phi,'haar');
  MPLL = dct2(mpLL);
  MPHL = dct2(mpHL);
  MPLH = dct2(mpLH);
  MPHH = dct2(mpHH);
  [U2, S2, V2] = svd(MPLL);
%   [UHL2, SHL2, VHL2] = svd(MPHL);
%   [ULH2, SLH2, VLH2] = svd(MPLH);
%   [UHH2, SHH2, VHH2] = svd(MPHH);
%   load SC2I.mat SC2I
%   S2=sort(S2);
%   S2=S2(SC2I);
%   load SW21I.mat SW21I
%   SHL2=sort(SHL2);
%   SHL2=SHL2(SW21I);
%   load SW22I.mat SW22I
%   SLH2=sort(SLH2);
%   SLH2=SLH2(SW22I);
%   load SW23I.mat SW23I
%   SHH2=sort(SHH2);
%   SHH2=SHH2(SW23I);
  [laLL,laHL,laLH,laHH] = dwt2(la,'haar');
  LALL = dct2(laLL);
  LAHL = dct2(laHL);
  LALH = dct2(laLH);
  LAHH = dct2(laHH);
  [U3, S3, V3] = svd(LALL);
%   [UHL3, SHL3, VHL3] = svd(LAHL);
%   [ULH3, SLH3, VLH3] = svd(LALH);
%   [UHH3, SHH3, VHH3] = svd(LAHH);
%   load SC3I.mat SC3I
%   S3=sort(S3);
%   S3=S3(SC3I);
%   load SW31I.mat SW31I
%   SHL3=sort(SHL3);
%   SHL3=SHL3(SW31I);
%   load SW32I.mat SW32I
%   SLH3=sort(SLH3);
%   SLH3=SLH3(SW32I);
%   load SW33I.mat SW33I
%   SHH3=sort(SHH3);
%   SHH3=SHH3(SW33I);
% 4 band cua anh watermark
    
    %Doc anh can anh vao
    %Igiau=imread('D:\wuan\code\DWT-MWT1\school.png'); 
    load original.mat orig
    Igiau = double(orig)/255;
    figure(1),imshow(Igiau),title('原图');
    sy=Igiau;
    shy=sh;
%     mwt_RY = mwt_radial( 'a' , Igiau(:,:,1) , L , param ); % Channelwise MWT
%     mwt_GY = mwt_radial( 'a' , Igiau(:,:,2) , L , param ); % Channelwise MWT
%     mwt_BY = mwt_radial( 'a' , Igiau(:,:,3) , L , param ); % Channelwise MWT  
%     sy  = cimg( mwt_RY{L,1} , mwt_GY{L,1} , mwt_BY{L,1} ); % Primary color subband
%     sxy = cimg( mwt_RY{L,2} , mwt_GY{L,2} , mwt_BY{L,2} ); % Riesz-x color subband
%     syy = cimg( mwt_RY{L,3} , mwt_GY{L,3} , mwt_BY{L,3} ); % Riesz-y color subband
%   
%   % - Riesz-based structure tensor analysis:
%   [n2,lambdaP2,coher2,ori2] = tensor(sxy,syy,0.5); 
%   clear n2 lambdaP2;
%   shy = ( sxy .* cimg(cos(ori2)) + syy .* cimg(sin(ori2)) ); % directional RT
  % - Ellipse parameters along local direction:
  [kap2,la2, phi2 ,a12,a22,a32] = ellipse31( sy , shy );
  [opLL,opHL,opLH,opHH] = dwt2(kap2,'haar');
  OPLL = dct2(opLL);
  OPHL = dct2(opHL);
  OPLH = dct2(opLH);
  OPHH = dct2(opHH);
  [UW1, SW1, VW1] = svd(OPLL);
  test2=SW1;
%   [UWHL1, SWHL1, VWHL1] = svd(OPHL);
%   [UWLH1, SWLH1, VWLH1] = svd(OPLH);
%   [UWHH1, SWHH1, VWHH1] = svd(OPHH);
%   load S1I.mat S1I
%   SW1=sort(SW1);
%   SW1=SW1(S1I);
%   test5=SW1;
%   load SHL1I.mat SHL1I
%   SWHL1=sort(SWHL1);
%   SWHL1=SWHL1(SHL1I);
%   load SLH1I.mat SLH1I
%   SWLH1=sort(SWLH1);
%   SWLH1=SWLH1(SLH1I);
%   load SHH1I.mat SHH1I
%   SWHH1=sort(SWHH1);
%   SWHH1=SWHH1(SHH1I);
  [ppLL,ppHL,ppLH,ppHH] = dwt2(phi2,'haar');
  PPLL = dct2(ppLL);
  PPHL = dct2(ppHL);
  PPLH = dct2(ppLH);
  PPHH = dct2(ppHH);
  %OPHI = dct2(phi2);
  [UW2, SW2, VW2] = svd(PPLL);
%   [UWHL2, SWHL2, VWHL2] = svd(PPHL);
%   [UWLH2, SWLH2, VWLH2] = svd(PPLH);
%   [UWHH2, SWHH2, VWHH2] = svd(PPHH);
%   load S2I.mat S2I
%   SW2=sort(SW2);
%   SW2=SW2(S2I);
%   load SHL2I.mat SHL2I
%   SWHL2=sort(SWHL2);
%   SWHL2=SWHL2(SHL2I);
%   load SLH2I.mat SLH2I
%   SWLH2=sort(SWLH2);
%   SWLH2=SWLH2(SLH2I);
%   load SHH2I.mat SHH2I
%   SWHH2=sort(SWHH2);
%   SWHH2=SWHH2(SHH2I);
  [lpLL,lpHL,lpLH,lpHH] = dwt2(la2,'haar');
  LPLL = dct2(lpLL);
  LPHL = dct2(lpHL);
  LPLH = dct2(lpLH);
  LPHH = dct2(lpHH);
  [UW3, SW3, VW3] = svd(LPLL);
%   [UWHL3, SWHL3, VWHL3] = svd(LPHL);
%   [UWLH3, SWLH3, VWLH3] = svd(LPLH);
%   [UWHH3, SWHH3, VWHH3] = svd(LPHH);
%   load S3I.mat S3I
%   SW3=sort(SW3);
%   SW3=SW3(S3I);
%   load SHL3I.mat SHL3I
%   SWHL3=sort(SWHL3);
%   SWHL3=SWHL3(SHL3I);
%   load SLH3I.mat SLH3I
%   SWLH3=sort(SWLH3);
%   SWLH3=SWLH3(SLH3I);
%   load SHH3I.mat SHH3I
%   SWHH3=sort(SWHH3);
%   SWHH3=SWHH3(SHH3I);
  load Uw.mat UM1
  load Um.mat UM2
  load Ud.mat UM3
  load Vw.mat VM1
  load Vm.mat VM2
  load Vd.mat VM3
%   load UHL1.mat UHL1
%   load VHL1.mat VHL1
%   load ULH1.mat ULH1
%   load VLH1.mat VLH1
%   load UHH1.mat UHH1
%   load VHH1.mat VHH1
%   load UHL2.mat UHL2
%   load VHL2.mat VHL2
%   load ULH2.mat ULH2
%   load VLH2.mat VLH2
%   load UHH2.mat UHH2
%   load VHH2.mat VHH2
%   load UHL3.mat UHL3
%   load VHL3.mat VHL3
%   load ULH3.mat ULH3
%   load VLH3.mat VLH3
%   load UHH3.mat UHH3
%   load VHH3.mat VHH3
  load mkap.mat mkap
  load wla.mat wla
  load mla.mat mla
  load wphi.mat wphi
  load wa1.mat wa1
  load ma1.mat ma1
  load wa2.mat wa2
  load ma2.mat ma2
  load wa3.mat wa3
  load ma3.mat ma3
  load dkap.mat dkap
  load dphi.mat dphi
  load da1.mat da1
  load da2.mat da2
  load da3.mat da3
%   load SU11.mat SU11
%   load SU12.mat SU12
%   load SU13.mat SU13
%   load SV11.mat SV11
%   load SV12.mat SV12
%   load SV13.mat SV13
%   load SU21.mat SU21
%   load SU22.mat SU22
%   load SU23.mat SU23
%   load SV21.mat SV21
%   load SV22.mat SV22
%   load SV23.mat SV23
%   load SU31.mat SU31
%   load SU32.mat SU32
%   load SU33.mat SU33
%   load SV31.mat SV31
%   load SV32.mat SV32
%   load SV33.mat SV33
% Xu Ly
  %S1=keyAttack(S1);
  SR1 = (S1 - SW1) * 25;
  %load SM1I.mat SM1
  %SR1=SM1;
%   load SM1I.mat SM1I
%   SR1=sort(SR1);
%   SR1=SR1(SM1I);
  SR2 = (S2 - SW2) * 20;
%   load SM2I.mat SM2I
%   SR2=sort(SR2);
%   SR2=SR2(SM2I);
  SR3 = (S3 - SW3) * 100;
%   load SM3I.mat SM3I
%   SR3=sort(SR3);
%   SR3=SR3(SM3I);
%  SS11 = (SHL1 - SWHL1)*10;
 %load SS11I.mat SS11
%   load SS11I.mat SS11I
%   SS11=sort(SS11);
%   SS11=SS11(SS11I);
  %SS11=sort(triu(SS11,1),2) + diag(diag(SS11)) + sort(triu(SS11,1),2)';
%  SS12 = (SLH1 - SWLH1)*10;
 %load SS12I.mat SS12
%  load SS12I.mat SS12I
%  SS12=sort(SS12);
%  SS12=SS12(SS12I);
%  SS13 = (SHH1 - SWHH1)*10;
 %load SS13I.mat SS13
%   load SS13I.mat SS13I
%   SS13=sort(SS13);
%   SS13=SS13(SS13I);
%   SS21 = (SHL2 - SWHL2)*10;
%   load SS21I.mat SS21I
%   SS21=sort(SS21);
%   SS21=SS21(SS21I);
%   SS22 = (SLH2 - SWLH2)*10;
%   load SS22I.mat SS22I
%   SS22=sort(SS22);
%   SS22=SS22(SS22I);
%   SS23 = (SHH2 - SWHH2)*10;
%   load SS23I.mat SS23I
%   SS23=sort(SS23);
%   SS23=SS23(SS23I);
%   SS31 = (SHL3 - SWHL3)*10;
%   load SS31I.mat SS31I
%   SS31=sort(SS31);
%   SS31=SS31(SS31I);
%   SS32 = (SLH3 - SWLH3)*10;
%   load SS32I.mat SS32I
%   SS32=sort(SS32);
%   SS32=SS32(SS32I);
%   SS33 = (SHH3 - SWHH3)*10;
%   load SS33I.mat SS33I
%   SS33=sort(SS33);
%   SS33=SS33(SS33I);
  I1_s11 = UM1 * SR1 * VM1';
  I1_s12 = UM2 * SR2 * VM2';
  I1_s13 = UM3 * SR3 * VM3';
%   IS1_s1 = SU11 * SS11 * SV11';
%   IS1_s2 = SU12 * SS12 * SV12';
%   IS1_s3 = SU13 * SS13 * SV13';
%   IS2_s1 = SU21 * SS21 * SV21';
%   IS2_s2 = SU22 * SS22 * SV22';
%   IS2_s3 = SU23 * SS23 * SV23';
%   IS3_s1 = SU31 * SS31 * SV31';
%   IS3_s2 = SU32 * SS32 * SV32';
%   IS3_s3 = SU33 * SS33 * SV33';
   I1_d11 = idct2(I1_s11);
%   IS1_d1 = idct2(IS1_s1);
%   load SR1HL.mat SR1HL
%   load SR1LH.mat SR1LH
%   load SR1HH.mat SR1HH
%   IS1_d1 = idwt2(IS1_d1,SR1HL,SR1LH,SR1HH,'haar', [512,512]);
%   IS1_d2 = idct2(IS1_s2);
%   load SG1HL.mat SG1HL
%   load SG1LH.mat SG1LH
%   load SG1HH.mat SG1HH
%   IS1_d2 = idwt2(IS1_d2,SG1HL,SG1LH,SG1HH,'haar', [512,512]);
%   IS1_d3 = idct2(IS1_s3);
%   load SB1HL.mat SB1HL
%   load SB1LH.mat SB1LH
%   load SB1HH.mat SB1HH
%   IS1_d3 = idwt2(IS1_d3,SB1HL,SB1LH,SB1HH,'haar', [512,512]);
%   %IS1_d1=imresize(IS1_d1,[512 512],'bilinear');
%   %IS1_d2=imresize(IS1_d2,[512 512],'bilinear');
%   %IS1_d3=imresize(IS1_d3,[512 512],'bilinear');
%   sav_R2 = mwt_radial( 'a' , IS1_d1 , L , param );
%   sav_G2 = mwt_radial( 'a' , IS1_d2 , L , param );
%   sav_B2 = mwt_radial( 'a' , IS1_d3 , L , param );
%   IS2_d1 = idct2(IS2_s1);
%   load SR2HL.mat SR2HL
%   load SR2LH.mat SR2LH
%   load SR2HH.mat SR2HH
%   IS2_d1 = idwt2(IS2_d1,SR2HL,SR2LH,SR2HH,'haar', [512,512]);
%   IS2_d2 = idct2(IS2_s2);
%   load SG2HL.mat SG2HL
%   load SG2LH.mat SG2LH
%   load SG2HH.mat SG2HH
%   IS2_d2 = idwt2(IS2_d2,SG2HL,SG2LH,SG2HH,'haar', [512,512]);
%   IS2_d3 = idct2(IS2_s3);
%   load SB2HL.mat SB2HL
%   load SB2LH.mat SB2LH
%   load SB2HH.mat SB2HH
%   IS2_d3 = idwt2(IS2_d3,SB2HL,SB2LH,SB2HH,'haar', [512,512]);
%   sav_R3 = mwt_radial( 'a' , IS2_d1 , L , param );
%   sav_G3 = mwt_radial( 'a' , IS2_d2 , L , param );
%   sav_B3 = mwt_radial( 'a' , IS2_d3 , L , param );
%   IS3_d1 = idct2(IS3_s1);
%   load SR3HL.mat SR3HL
%   load SR3LH.mat SR3LH
%   load SR3HH.mat SR3HH
%   IS3_d1 = idwt2(IS3_d1,SR3HL,SR3LH,SR3HH,'haar', [512,512]);
%   IS3_d2 = idct2(IS3_s2);
%   load SG3HL.mat SG3HL
%   load SG3LH.mat SG3LH
%   load SG3HH.mat SG3HH
%   IS3_d2 = idwt2(IS3_d2,SG3HL,SG3LH,SG3HH,'haar', [512,512]);
%   IS3_d3 = idct2(IS3_s3);
%   load SB3HL.mat SB3HL
%   load SB3LH.mat SB3LH
%   load SB3HH.mat SB3HH
%   IS3_d3 = idwt2(IS3_d3,SB3HL,SB3LH,SB3HH,'haar', [512,512]);
%   sav_R4 = mwt_radial( 'a' , IS3_d1 , L , param );
%   sav_G4 = mwt_radial( 'a' , IS3_d2 , L , param );
%   sav_B4 = mwt_radial( 'a' , IS3_d3 , L , param );
  load AHL.mat aHL
  load ALH.mat aLH
  load AHH.mat aHH
  I1_d11 = idwt2(I1_d11, aHL, aLH, aHH, 'haar', [512,512]);
  I1_d12 = idct2(I1_s12);
  load PHL.mat pHL
  load PLH.mat pLH
  load PHH.mat pHH
  I1_d12 = idwt2(I1_d12, pHL, pLH, pHH, 'haar', [512,512]);
  I1_d13 = idct2(I1_s13);
  load DHL.mat dHL
  load DLH.mat dLH
  load DHH.mat dHH
  I1_d13 = idwt2(I1_d13, dHL, dLH, dHH, 'haar', [512,512]);
% Ket Qua
  [s1,sh1] = ellipse3_back1(I1_d11,wla,wphi,wa1,wa2,wa3);
  [s2,sh2] = ellipse3_back1(mkap,mla,I1_d12,ma1,ma2,ma3);
  [s3,sh3] = ellipse3_back1(dkap,I1_d13,dphi,da1,da2,da3);
%   s21=s2(:,:,1);
%   s22=s2(:,:,2);
%   s23=s2(:,:,3);
%   load sx2.mat sx2
%   load sy2.mat sy2
%   load sx3.mat sx3
%   load sy3.mat sy3
%   load sx4.mat sx4
%   load sy4.mat sy4
%   load MWT21.mat mwt_R2
%   load MWT22.mat mwt_G2
%   load MWT23.mat mwt_B2
%   load MWT31.mat mwt_R3
%   load MWT32.mat mwt_G3
%   load MWT33.mat mwt_B3
%   load MWT41.mat mwt_R4
%   load MWT42.mat mwt_G4
%   load MWT43.mat mwt_B4
%   rec_R2 = sav_R2;
%   rec_R2{L,1}=s1(:,:,1);
%   %rec_R2{L,2}=sx2(:,:,1);
%   %rec_R2{L,3}=sy2(:,:,1);
%   rec_G2 = sav_G2;
%   rec_G2{L,1}=s1(:,:,2);
%   %rec_G2{L,2}=sx2(:,:,2);
%   %rec_G2{L,3}=sy2(:,:,2);  
%   rec_B2 = sav_B2;
%   rec_B2{L,1}=s1(:,:,3);
%   %rec_B2{L,2}=sx2(:,:,3);
%   %rec_B2{L,3}=sy2(:,:,3);
%   %rec_R2{1,1}=mwt_R2{1,1};
%   %rec_R2{1,2}=mwt_R2{1,2};
%   %rec_R2{1,3}=mwt_R2{1,3};
%   %rec_R2{2,1}=mwt_R2{2,1};
%   %rec_R2{2,2}=mwt_R2{2,2};
%   %rec_R2{2,3}=mwt_R2{2,3};
%   %rec_R2{3,1}=mwt_R2{3,1};
%   %rec_R2{3,2}=mwt_R2{3,2};
%   %rec_R2{3,3}=mwt_R2{3,3};
%   %rec_R2{4,1}=mwt_R2{4,1};
%   %rec_R2{4,2}=mwt_R2{4,2};
%   %rec_R2{4,3}=mwt_R2{4,3};
%   %rec_G2{1,1}=mwt_G2{1,1};
%   %rec_G2{1,2}=mwt_G2{1,2};
%   %rec_G2{1,3}=mwt_G2{1,3};
%   %rec_G2{2,1}=mwt_G2{2,1};
%   %rec_G2{2,2}=mwt_G2{2,2};
%   %rec_G2{2,3}=mwt_G2{2,3};
%   %rec_G2{3,1}=mwt_G2{3,1};
%   %rec_G2{3,2}=mwt_G2{3,2};
%   %rec_G2{3,3}=mwt_G2{3,3};
%   %rec_G2{4,1}=mwt_G2{4,1};
%   %rec_G2{4,2}=mwt_G2{4,2};
%   %rec_G2{4,3}=mwt_G2{4,3};
%   %rec_B2{1,1}=mwt_B2{1,1};
%   %rec_B2{1,2}=mwt_B2{1,2};
%   %rec_B2{1,3}=mwt_B2{1,3};
%   %rec_B2{2,1}=mwt_B2{2,1};
%   %rec_B2{2,2}=mwt_B2{2,2};
%   %rec_B2{2,3}=mwt_B2{2,3};
%   %rec_B2{3,1}=mwt_B2{3,1};
%   %rec_B2{3,2}=mwt_B2{3,2};
%   %rec_B2{3,3}=mwt_B2{3,3};
%   %rec_B2{4,1}=mwt_B2{4,1};
%   %rec_B2{4,2}=mwt_B2{4,2};
%   %rec_B2{4,3}=mwt_B2{4,3};
%   %rec_R2{L+1,1}=mwt_R2{L+1,1};
%   %rec_R2{L+1,1}=mwt_R2{1,1};
%   %rec_R2{L+1,1}=0;
%   %rec_G2{L+1,1}=mwt_G2{L+1,1};
%   %rec_G2{L+1,1}=mwt_G2{1,1};
%   %rec_G2{L+1,1}=0;
%   %rec_B2{L+1,1}=mwt_B2{L+1,1};
%   %rec_B2{L+1,1}=mwt_B2{1,1};
%   %rec_B2{L+1,1}=0;
%   rec_R11 = mwt_radial( 's' , rec_R2 , L , param ); 
%   rec_G11 = mwt_radial( 's' , rec_G2 , L , param ); 
%   rec_B11 = mwt_radial( 's' , rec_B2 , L , param ); 
  WaterMarked1=s1;
  s11=s1(:,:,1);
  s12=s1(:,:,2);
  s13=s1(:,:,3);
  %figure(5);
  %wm1=surf(double(s11),double(s12),double(s13));
  figure(15); 
  imwrite(WaterMarked1,'D:\wuan\code\DWT-MWT1\mwt-w.bmp','bmp');
  imshow(WaterMarked1,[]); title('Watermarke1 of Image'); 
%   rec_R3 = sav_R3;
%   rec_R3{L,1}=s2(:,:,1);
%   %rec_R3{L,1}=mwt_R3{1,1};
%   %rec_R3{L,2}=sx3(:,:,1);
%   %rec_R3{L,3}=sy3(:,:,1);
%   rec_G3 = sav_G3;
%   rec_G3{L,1}=s2(:,:,2);
%   %rec_G3{L,1}=mwt_R3{1,1};
%   %rec_G3{L,2}=sx3(:,:,2);
%   %rec_G3{L,3}=sy3(:,:,2); 
%   rec_B3 = sav_B3;
%   rec_B3{L,1}=s2(:,:,3);
%   %rec_B3{L,1}=mwt_R3{1,1};
%   %rec_B3{L,2}=sx3(:,:,3);
%   %rec_B3{L,3}=sy3(:,:,3);
%   %rec_R3{1,1}=mwt_R3{1,1};
%   %rec_R3{1,2}=mwt_R3{1,2};
%   %rec_R3{1,3}=mwt_R3{1,3};
%   %rec_R3{2,1}=mwt_R3{2,1};
%   %rec_R3{2,2}=mwt_R3{2,2};
%   %rec_R3{2,3}=mwt_R3{2,3};
%   %rec_R3{3,1}=mwt_R3{3,1};
%   %rec_R3{3,2}=mwt_R3{3,2};
%   %rec_R3{3,3}=mwt_R3{3,3};
%   %rec_R3{4,1}=mwt_R3{4,1};
%   %rec_R3{4,2}=mwt_R3{4,2};
%   %rec_R3{4,3}=mwt_R3{4,3};
%   %rec_G3{1,1}=mwt_G3{1,1};
%   %rec_G3{1,2}=mwt_G3{1,2};
%   %rec_G3{1,3}=mwt_G3{1,3};
%   %rec_G3{2,1}=mwt_G3{2,1};
%   %rec_G3{2,2}=mwt_G3{2,2};
%   %rec_G3{2,3}=mwt_G3{2,3};
%   %rec_G3{3,1}=mwt_G3{3,1};
%   %rec_G3{3,2}=mwt_G3{3,2};
%   %rec_G3{3,3}=mwt_G3{3,3};
%   %rec_G3{4,1}=mwt_G3{4,1};
%   %rec_G3{4,2}=mwt_G3{4,2};
%   %rec_G3{4,3}=mwt_G3{4,3};
%   %rec_B3{1,1}=mwt_B3{1,1};
%   %rec_B3{1,2}=mwt_B3{1,2};
%   %rec_B3{1,3}=mwt_B3{1,3};
%   %rec_B3{2,1}=mwt_B3{2,1};
%   %rec_B3{2,2}=mwt_B3{2,2};
%   %rec_B3{2,3}=mwt_B3{2,3};
%   %rec_B3{3,1}=mwt_B3{3,1};
%   %rec_B3{3,2}=mwt_B3{3,2};
%   %rec_B3{3,3}=mwt_B3{3,3};
%   %rec_B3{4,1}=mwt_B3{4,1};
%   %rec_B3{4,2}=mwt_B3{4,2};
%   %rec_B3{4,3}=mwt_B3{4,3};
%   %rec_R3{L+1,1}=mwt_R3{L+1,1};
%   %rec_R3{L+1,1}=mwt_R3{1,1};
%   %rec_R3{L+1,1}=0;
%   %rec_G3{L+1,1}=mwt_G3{L+1,1};
%   %rec_G3{L+1,1}=mwt_G3{1,1};
%   %rec_G3{L+1,1}=0;
%   %rec_B3{L+1,1}=mwt_B3{L+1,1};
%   %rec_B3{L+1,1}=mwt_B3{1,1};
%   %rec_B3{L+1,1}=0;
%   rec_R22 = mwt_radial( 's' , rec_R3 , L , param ); 
%   rec_G22 = mwt_radial( 's' , rec_G3 , L , param ); 
%   rec_B22 = mwt_radial( 's' , rec_B3 , L , param );
  load Key.mat key
  %key=randi([10, 100], 256, 256);
  %key=keyAttack(key);
  rec_R221=IArnold (s2(:,:,1), key);
  rec_G222=IArnold (s2(:,:,2), key);
  rec_B223=IArnold (s2(:,:,3), key);
  WaterMarked2 = cimg(rec_R221,rec_G222,rec_B223);
  %figure(6)
  %wm2=surf(double(rec_R221),double(rec_G222),double(rec_B223));
  figure(16); 
  imwrite(WaterMarked2,'D:\wuan\code\DWT-MWT1\mwt-m.bmp','bmp');
  imshow(WaterMarked2,[]); title('Watermarke2 of Image'); 
%   rec_R4=sav_R4;
%   rec_R4{L,1}=s3(:,:,1);
%   %rec_R4{L,2}=sx4(:,:,1);
%   %rec_R4{L,3}=sy4(:,:,1);
%   rec_G4=sav_G4;
%   rec_G4{L,1}=s3(:,:,2);
%   %rec_G4{L,2}=sx4(:,:,2);
%   %rec_G4{L,3}=sy4(:,:,2);    
%   rec_B4=sav_B4;
%   rec_B4{L,1}=s3(:,:,3);
%   %rec_B4{L,2}=sx4(:,:,3);
%   %rec_B4{L,3}=sy4(:,:,3);
%   %rec_R4{1,1}=mwt_R4{1,1};
%   %rec_R4{1,2}=mwt_R4{1,2};
%   %rec_R4{1,3}=mwt_R4{1,3};
%   %rec_R4{2,1}=mwt_R4{2,1};
%   %rec_R4{2,2}=mwt_R4{2,2};
%   %rec_R4{2,3}=mwt_R4{2,3};
%   %rec_R4{3,1}=mwt_R4{3,1};
%   %rec_R4{3,2}=mwt_R4{3,2};
%   %rec_R4{3,3}=mwt_R4{3,3};
%   %rec_R4{4,1}=mwt_R4{4,1};
%   %rec_R4{4,2}=mwt_R4{4,2};
%   %rec_R4{4,3}=mwt_R4{4,3};
%   %rec_G4{1,1}=mwt_G4{1,1};
%   %rec_G4{1,2}=mwt_G4{1,2};
%   %rec_G4{1,3}=mwt_G4{1,3};
%   %rec_G4{2,1}=mwt_G4{2,1};
%   %rec_G4{2,2}=mwt_G4{2,2};
%   %rec_G4{2,3}=mwt_G4{2,3};
%   %rec_G4{3,1}=mwt_G4{3,1};
%   %rec_G4{3,2}=mwt_G4{3,2};
%   %rec_G4{3,3}=mwt_G4{3,3};
%   %rec_G4{4,1}=mwt_G4{4,1};
%   %rec_G4{4,2}=mwt_G4{4,2};
%   %rec_G4{4,3}=mwt_G4{4,3};
%   %rec_B4{1,1}=mwt_B4{1,1};
%   %rec_B4{1,2}=mwt_B4{1,2};
%   %rec_B4{1,3}=mwt_B4{1,3};
%   %rec_B4{2,1}=mwt_B4{2,1};
%   %rec_B4{2,2}=mwt_B4{2,2};
%   %rec_B4{2,3}=mwt_B4{2,3};
%   %rec_B4{3,1}=mwt_B4{3,1};
%   %rec_B4{3,2}=mwt_B4{3,2};
%   %rec_B4{3,3}=mwt_B4{3,3};
%   %rec_B4{4,1}=mwt_B4{4,1};
%   %rec_B4{4,2}=mwt_B4{4,2};
%   %rec_B4{4,3}=mwt_B4{4,3};
%   %rec_R4{L+1,1}=mwt_R4{L+1,1};
%   %rec_R2{L+1,1}=mwt_R2{1,1};
%   %rec_R2{L+1,1}=0;
%   %rec_G4{L+1,1}=mwt_G4{L+1,1};
%   %rec_G2{L+1,1}=mwt_G2{1,1};
%   %rec_G2{L+1,1}=0;
%   %rec_B4{L+1,1}=mwt_B4{L+1,1};
%   %rec_B2{L+1,1}=mwt_B2{1,1};
%   %rec_B2{L+1,1}=0;
%   rec_R33 = mwt_radial( 's' , rec_R4 , L , param ); 
%   rec_G33 = mwt_radial( 's' , rec_G4 , L , param ); 
%   rec_B33 = mwt_radial( 's' , rec_B4 , L , param );
  %load Key2.mat key2
  %key2=keyAttack(key2);
  rec_R331=IArnold (s3(:,:,1), key);
  rec_G332=IArnold (s3(:,:,2), key);
  rec_B333=IArnold (s3(:,:,3), key);
%   load key2.mat K
%   load ni1.mat ni1
%   load ni2.mat ni2
%   load ni3.mat ni3
%   load N1.mat N1
%   load Nn.mat Nn
%   load alpha.mat alpha
%   s3=imresize(s3,[256 256],'bilinear');
%   WaterMarked3 = decryptionf(s3, K, ni1 , ni2, ni3, N1, N1, N1, Nn, alpha);
%   WaterMarked3=uint8(WaterMarked3);
  WaterMarked3=cimg(rec_R331,rec_G332,rec_B333);
  %img=WaterMarked3;
  %img_double = im2double(img);
  % 定义滤波器大小，例如3x3
%filterSize = [4 4];
 
% 对每个颜色通道应用中值滤波
%img_filtered_red = medfilt2(img_double(:,:,1), filterSize);
%img_filtered_green = medfilt2(img_double(:,:,2), filterSize);
%img_filtered_blue = medfilt2(img_double(:,:,3), filterSize);
%img_filtered = cat(3, img_filtered_red, img_filtered_green, img_filtered_blue);
%img_filtered_uint8 = im2uint8(img_filtered);
%WaterMarked3=img_filtered_uint8 ;
%  figure(7);
%  wm3=surf(double(rec_R331),double(rec_G332),double(rec_B333));
  figure(17); 
  imwrite(WaterMarked3,'D:\wuan\code\DWT-MWT1\mwt-d.bmp','bmp');
  imshow(WaterMarked3,[]); title('Watermarke3 of Image'); 
%   save testnum2.mat test2
%   save testnum5.mat test5
toc;