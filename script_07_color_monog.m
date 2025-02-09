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
%   rsimg.m  ->  anglewrap.m (no dependency)   &   cimg.m (no dependency) 
%   ellipse3.m (no dependency)

% ----------------------------------------------------------------- %
% Script to illustrate the color elliptical monogenic signal
% ----------------------------------------------------------------- %



im = double(imread('lena.BMP'))/255;

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

[ka,la,phi,a1,a2,a3]=ellipse3(PRIM,RizDir);
amp = ka*sqrt(2);

% ----------------------------------------------------------------- %
% Generate illustrations of the result.
satu = (amp/max(amp(:)));
satu3= sqrt(satu.*(1-la));
figure;
orinorm = sqrt(rizN/max(rizN(:)));

imshow( [ rsimg(PRIM,'band') , rsimg(amp,'amp') , rsimg( phi ,'phaz',satu) , rsimg( ori ,'dir' ,satu ) ;...
          rsimg( 1-la ,'amp',1) , rsimg( a1,'dir',satu ) , rsimg( a2,'dir',satu ) , rsimg( a3,'dir',satu3 )  ]  );

% imwrite(  rsimg(PRIM,'band') ,'colormonogPRIM.png');
% imwrite(  rsimg(amp,'amp') ,'colormonogA.png');
% imwrite(  rsimg( phi ,'phaz',satu) ,'colormonogP.png');
% imwrite(  rsimg( ori ,'dir' ,satu ) ,'colormonogO.png');
% imwrite(  rsimg( 1-la ,'amp',1) ,'colormonogLa.png');
% imwrite(  rsimg( a1,'dir',satu ) ,'colormonogA1.png');
% imwrite(  rsimg( a2,'dir',satu ) ,'colormonogA2.png');
% imwrite(  rsimg( a3,'dir',satu3 ) ,'colormonogA3.png');


