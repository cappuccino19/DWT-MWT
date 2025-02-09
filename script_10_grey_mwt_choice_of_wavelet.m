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


% This script shows how the choice of wavelet 
% affects the smoothness of the monogenic amplitude enveloppe


% Supported wavelet types 'typ':
% {'GaussianHP'}                  [Soulard & Carre IEEE TPAMI 2017]
% {'GaussianLP'}                   Soulard & Carré (unpublished)
% {'Storath',ord} (ord in {0..5}) [Held, Storath et al. IEEE TIP 2010]
% {'UnserSimonc'}                 [Unser & Chenouard SIAM J.Im.Sci. 2013]
% {'UnserMeyer'}                  [Unser & Chenouard SIAM J.Im.Sci. 2013]
% {'UnserPapadakis'}              [Unser & Chenouard SIAM J.Im.Sci. 2013]
% {'UnserShannon'}                [Unser & Chenouard SIAM J.Im.Sci. 2013]
% {'PadU1D'}                      [Unser & Chenouard SIAM J.Im.Sci. 2013]


clear;

img = double(imread('face8.png'))/255;
img = img(1:2:end,1:2:end,:);
img = (img(:,:,1)+img(:,:,2)+img(:,:,3))/3;


typelist = { {'GaussianHP'} , {'UnserSimonc'} , {'PadU1D'} , {'Storath',2}  };
scallist = [   4 ,              3 ,               3  ,         3            ];
nb = length(scallist);

figure(1); clf;imshow(img); title('input test image');
figure(2);clf;
figure(3);clf;

for id=1:nb,

% MWT PARAMETERS: ------------------------------------------------------- %
param.typ = typelist{id}; % Soulard's fast decaying Gaussian-based wavelets
L = scallist(id); % wavelet scale
param.norma = true;   % normalize subbands
param.sampling = 'undec'; % 'undec' or 'pyramid'
param.noRzHF = true; % remove Riesz transform at first scale
% ----------------------------------------------------------------------- %

mwt = mwt_radial('a', img, L , param ); % MWT
amp = sqrt( mwt{L,1}.^2 + mwt{L,2}.^2 + mwt{L,3}.^2 );
amp = amp/max(amp(:));

figure(2);
subplot(nb,1,id);
imshow( 1 - amp );
title(sprintf('Scale %d amp. with wavelet %s', L , typelist{id}{1} ));

% ----------------------------------------------------------------------- %
% ---------- Radial profiles    ----------------------------------------- %
% ----------------------------------------------------------------------- %
di = zeros(512,512);
di(1)=1;
mwt = mwt_radial('a', di, L , param );
radp = fftshift( mwt{L,1}(1,:) );
radp = radp(206:306);
Radp = abs(fft2(mwt{L,1}));
Radp = Radp(1,1:256);

figure(3);
subplot(211); hold on; plot( radp , 'DisplayName', typelist{id}{1} );
subplot(212); hold on; plot( Radp , 'DisplayName', typelist{id}{1} );

end
figure(3);
subplot(211); title('Wavelet radial profile (space domain)');
subplot(212); title('Wavelet radial profile (frequency domain)');
legend('show');
disp('End of script.');
