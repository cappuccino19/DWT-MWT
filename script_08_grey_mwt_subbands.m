%
% This source code is freely distributed from the "colormonogenic" website:
% http://xlim-sic.labo.univ-poitiers.fr/projets/colormonogenic/
% published in 2018,
% which presents the main research results by 
% Raphaël Soulard & Philippe Carré,
% from the XLIM Laboratory (UMR CNRS 7252),
% University of Poitiers, France.
%
% Author: R. Soulard.
%

% Dependencies:
% - Greyscale Monogenic Wavelet Transform 
%   based on radial Fourier responses:
%
%   mwt_radial.m  ->  FFT_radial.m  (no dependency)
%                  &  mwt_get_filters.m  (no dependency)
%                  &  mwt_get_norm_csts.m  (no dependency)
% - Display utility:
%
%   rsimg.m  ->  cimg.m (no dependency)  &  anglewrap.m (no dependency)

%
% This script illustrates the greyscale monogenic filterbank
%


close all;
clear;

% Get test image:
img = double(imread('face8.png'))/255; 
img = img(32:32+100,16:16+100,1); 


% Process Monogenic Wavelet Transform:
param.typ = {'GaussianHP'}; % Fast decaying wavelets from [Soulard IEEE TPAMI 2017]
param.norma = false;        % Subband normalization
param.sampling = 'undec';   % Undecimated design (instead of 'pyramid')
param.noRzHF = false;       % Remove Riesz transform at first scale
L = 4;                      % Decomposition depth (number of scales)
mwt = mwt_radial('a',img,L,param); % monogenic wavelet transform


% Process reverse transform to test perfect reconstruction:
rec = mwt_radial('s',mwt,L,param); % inverse monogenic wavelet transform
fprintf('Maximum reconstruction error = %.16f\n',max(max(abs(img-rec))));


% Illustrate the multiscale monogenic analysis:
scal1 = 1; % choose scales to be displayed
scal2 = L; % choose scales to be displayed
HF = [];  AM = [];  PH = [];  TH = [];
for i=scal1:scal2,
  s = mwt{i,1};
  sx= mwt{i,2};
  sy= mwt{i,3}; 
  rn = sqrt( sx.^2 + sy.^2 );
  th = atan2( sy , sx );
  am = sqrt( s.^2 + rn.^2 );
  ph = atan2( rn , s );
  HF = [ HF ; [s,sx,sy] ];
  AM = [ AM ; am ];
  PH = [ PH ; ph ];
  TH = [ TH ; th ];
end
mx  = max(abs( [HF(:);AM(:)] )); % Normalization value for diplay
AM2 = AM>0.1; % Amplitude-based mask for phase/orientation displaying
illus = [ rsimg(HF,'band',mx) , rsimg(AM,'amp',mx) , rsimg(PH,'phaz',AM2) , rsimg(TH,'dir',AM2) ];

titl = strcat( {'Greyscale Monogenic Wavelet Transform from scales '} , num2str(scal1) , {' to '} , num2str(scal2) );
titl = sprintf('Greyscale Monogenic Wavelet Transform from scales i=%d:%d\n(  s_{i,isotr}   s_{i,riesz-1}   s_{i,riesz-2}   >>>   amp_i   phase_i   orient_i  )',scal1,scal2);

figure; imshow(illus);
title(titl);

disp('End of script.');
