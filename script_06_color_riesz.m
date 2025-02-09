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
%   FFT_bandpass_mask.m  ->  FFT_radial.m (no dependency)
%   tensor.m (no dependency)
%   cimg.m   (no dependency)
%   rsimg.m  ->  anglewrap.m (no dependency)  &   cimg.m (no dependency)

% ----------------------------------------------------------------- %
% Script to illustrate the color Riesz transform
% ----------------------------------------------------------------- %

im = double(imread('face8.png'))/255;

[M,N,~] = size(im);

% ----------------------------------------------------------------- %
% Isotropic linear-phase band-pass 2d filter in the FFT domain.
rad_bounds = pi*[ 0 2 4 11 ]*2*pi/min(M,N); % Radial frequency coordinate (in radians)
mask = FFT_bandpass_mask([M,N],rad_bounds);

% ----------------------------------------------------------------- %
% Perform Riesz transform on the input image.
% Frequency coordinates:
[W1,W2] = ndgrid(  (-floor(M/2):ceil(M/2)-1)/M  ,...
                   (-floor(N/2):ceil(N/2)-1)/N  );
% Numerical approximation of the Riesz transform in the FFT domain:
RZ = ifftshift(  -1i * exp(  1i*atan2(W2,W1)  )    ); 

SP = cimg( fft2(im(:,:,1)),...    % input image FFT
           fft2(im(:,:,2)),...    % input image FFT
           fft2(im(:,:,3))     ); % input image FFT

PRIM = cimg( real(ifft2( SP(:,:,1) .* mask )),...    % bandpass filtering
             real(ifft2( SP(:,:,2) .* mask )),...    % bandpass filtering
             real(ifft2( SP(:,:,3) .* mask ))     ); % bandpass filtering

RIZ = cimg( ifft2( SP(:,:,1) .* mask .* RZ ),...    % Riesz transform
            ifft2( SP(:,:,2) .* mask .* RZ ),...    % Riesz transform
            ifft2( SP(:,:,3) .* mask .* RZ )     ); % Riesz transform

[N,la,co,ori]=tensor( real(RIZ) , imag(RIZ) , 0.5 );

RizDir = real(RIZ).*cimg(cos(ori)) + imag(RIZ).*cimg(sin(ori));
rizN = sqrt(sum( abs(RIZ).^2 ,3));   % color Riesz norm

% ----------------------------------------------------------------- %
% Generate illustrations of the result.

figure;
orinorm = sqrt(rizN/max(rizN(:)));
imshow( [ rsimg(PRIM,'band') , rsimg(real(RIZ),'band') , rsimg(imag(RIZ),'band') , rsimg(ori,'dir',orinorm) , rsimg(RizDir,'band') , rsimg(rizN,'amp') ]  );

%imwrite(  rsimg( rizN ,'amp') ,'colorrieszN.png');
%imwrite(  rsimg( ori ,'dir',orinorm) ,'colorrieszO.png');
%imwrite(  rsimg(PRIM,'band') ,'colorrieszPRIM.png');
%imwrite(  rsimg(real(RIZ),'band') ,'colorrieszRIZX.png');
%imwrite(  rsimg(imag(RIZ),'band') ,'colorrieszRIZY.png');
%imwrite(  rsimg(RizDir,'band') ,'colorrieszRIZD.png');

