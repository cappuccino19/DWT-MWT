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
% This script illustrates the classical "wavelet shrinkage" 
% denoising method with the greyscale monogenic filterbank.
%


close all;
clear;

% Monogenic Wavelet Transform parameters:
param.typ = {'GaussianHP'}; % Fast decaying wavelets from [Soulard IEEE TPAMI 2017]
param.norma = true;        % Subband normalization
param.sampling = 'undec';   % Undecimated design (instead of 'pyramid')
param.noRzHF = true;       % Remove Riesz transform at first scale


L=5; % Decomposition depth (number of scales)

% Get test image:
img = double(imread('lena.BMP'))/255; 
img = img(:,:,1); 


T = 0.15;  % Amplitude threshold for shrinkage
snr = 25;  % Noise SNR for noisy test image

img2 = awgn( img , snr ); % Noisy test image
mwt = mwt_radial('a',img2,L,param); % Monogenic Wavelet Transform


% Wavelet shrinkage:
for scal=1:L,
  amp = sqrt(mwt{scal,1}.^2+abs(mwt{scal,2}+1i*mwt{scal,3}).^2);
  idx = amp<T; % detect noisy low amplitude values
  for k=1:3, % for primary part, Riesz-x part and Riesz-y part:
    mwt{scal,k}(idx) = 0; % zero out corresponding monogenic coefficients
  end
end

% Special processing for first scale:
amp1 = sqrt(mwt{1,1}.^2+abs(mwt{1,2}+1i*mwt{1,3}).^2); % 1st scale amp
amp2 = sqrt(mwt{2,1}.^2+abs(mwt{2,2}+1i*mwt{2,3}).^2); % 2nd scale amp
idx = amp1>0.8*amp2; % Detect suspiciously high 1st scale coeffs
mwt{1,1}(idx) = 0; % shrink primary part
mwt{1,2} = mwt{1,1}.*0; % zero out the whole Riesz part
mwt{1,3} = mwt{1,1}.*0; % zero out the whole Riesz part

% Reconstruction:
rec2 = mwt_radial('s',mwt,L,param); % inverse monogenic wavelet transform
figure();
imshow([img,img2,rec2]);
title(sprintf('MWT shrinkage with snr=%2.1fdB and thresh=%1.2f (%d scales)',snr,T,L));


disp('End of script.');
