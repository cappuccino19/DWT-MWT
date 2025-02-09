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


% This script shows the Elliptical monogenic color analysis 
% in a filterbank implementation.

clear;


% MWT PARAMETERS: ------------------------------------------------------- %
param.typ = {'GaussianHP'}; % Soulard's fast decaying Gaussian-based wavelets
param.norma = true;   % normalize subbands
param.sampling = 'undec'; % 'undec' or 'pyramid'
param.noRzHF = true; % remove Riesz transform at first scale
% ----------------------------------------------------------------------- %

img = double(imread('lena.bmp'))/255; % input color image

L = 5; % Decomposition depth (last scale i=L will be displayed only)

% Process wavelet transform:
  
mwt_R = mwt_radial( 'a' , img(:,:,1) , L , param ); % Channelwise MWT
mwt_G = mwt_radial( 'a' , img(:,:,2) , L , param ); % Channelwise MWT
mwt_B = mwt_radial( 'a' , img(:,:,3) , L , param ); % Channelwise MWT


for i=1:L,
  s  = cimg( mwt_R{i,1} , mwt_G{i,1} , mwt_B{i,1} ); % Primary color subband
  sx = cimg( mwt_R{i,2} , mwt_G{i,2} , mwt_B{i,2} ); % Riesz-x color subband
  sy = cimg( mwt_R{i,3} , mwt_G{i,3} , mwt_B{i,3} ); % Riesz-y color subband
  
  % - Riesz-based structure tensor analysis:
  [n,lambdaP,coher,ori] = tensor(sx,sy,0.5); 
  clear n lambdaP;
  sh = ( sx .* cimg(cos(ori)) + sy .* cimg(sin(ori)) ); % directional RT
  % - Ellipse parameters along local direction:
  [kap,la, phi ,a1,a2,a3] = ellipse3( s , sh );
  amp = kap*sqrt(2); % Monogenic amplitude
  
  amp_mask = double(amp>0.35*max(amp(:)));
  Rmask = amp_mask .* (1-la > 0.1); % thresholded amp and thresholded linearity
  illus = rsimg( amp , 'amp' ); % amplitude in R+
  illus = [ illus , rsimg( phi , 'phaz' , amp_mask ) ]; % phi is in [-pi;pi]
  illus = [ illus , rsimg( ori , 'dir' , amp_mask ) ]; % ori is in [-pi/2;pi/2]
  illus = [ illus , rsimg( 1-la, 'amp' , 1 ) ]; % lambda is in [0;1]
  illus = [ illus , rsimg( a1  , 'dir' , amp_mask ) ]; % a1 is in [-pi/2;pi/2]
  illus = [ illus , rsimg( a2  , 'dir' , amp_mask ) ]; % a2 is in [-pi/2;pi/2]
  illus = [ illus , rsimg( a3  , 'dir' , Rmask ) ]; % a3 is in [-pi;pi]
  %illus = [ illus , rsimg( coher  , 'amp' , 1 ) ]; % coherency in [0;1]
  
  figure(i);
  imshow(illus);
  %imshow(WaterMarked);
  imwrite(illus,sprintf('emwt%d.png',i));
  title(sprintf('EMWT at scale %d (amp,phase,orient,lambda,alpha1,alpha2,alpha3)',i));
end

disp('End of script.');
