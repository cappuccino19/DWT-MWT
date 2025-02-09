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
%   mwt_radon.m   ->  mwt_radon_FFT_slices.m (No dependency)
%                     
% - Display utility:
%
%   rsimg.m  ->  cimg.m (no dependency)  &  anglewrap.m (no dependency)


%
% This script is exactly the same as script_09_grey_mwt_wavelets
% except that it used 'mwt_radon' instead of 'mwt_radial', 
% so as to show modulated wavelets with the Radon-based monogenic filterbank.
%

close all;
clear;

% Monogenic Wavelet Transform parameters:
param.norma = false;        % Subband normalization
param.noRzHF = false;       % Remove Riesz transform at first scale

% Synthesis wavelet generation parameters:
scal = 6; % scale of the wavelet to be synthesised 
N = 193;  % full size of subbands
Ncrop = 48; % wavelet will be cropped
phis   = [ 0 pi/2   pi/2     pi/3   pi/2 ]; % Examples of phase 
thetas = [ 0  pi  -2*pi/3   -pi/3  -pi/6 ]; % Examples of orientation



% Prepare the generation of the corresponding synthesis wavelets:
nb = length(phis);  % number of examples
norma_val = 0;      % init normalization for final display
amp = 2^(2*(scal-1));                  % Define amplitude value
s_iso = amp*cos(phis);                 % Convert phase/orientation 
s_ri1 = amp*sin(phis).*cos(thetas);    %   values to Cartesian 
s_ri2 = amp*sin(phis).*sin(thetas);    %    monogenic coefficients
nmid = ceil(N/2);                      % Middle coordinate to set the wavelet coeff
ncrop = nmid+(-Ncrop:Ncrop);           % Coordinates for final cropping
illus = cell(nb,1);                    % Init list of results



% Generate several synthesis wavelets:
for i=1:nb, % for each wavelet to be illustrated

  % Init empty wavelet transform:
  wt = cell(scal+1,3); 
  for ii=1:scal, % for all scales
    for jj=1:3,  % for each component (iso, riesz-1, riesz2)
      wt{ii,jj} = zeros(N,N); % fill with zeroes
    end
  end
  wt{scal+1,1} = zeros(N,N); % fill the low-freq band with zeroes
  
  % Set one non-zero coefficient at the last scale:
  wt{scal,1}(nmid,nmid) = s_iso(i);   % Set primary part
  wt{scal,2}(nmid,nmid) = s_ri1(i);   % Set x-Riesz part
  wt{scal,3}(nmid,nmid) = s_ri2(i);   % Set y-Riesz part
  im = mwt_radon('s',wt,scal,param.noRzHF,param.norma); % Reverse Monogenic Wavelet Transform
  
  im = im(ncrop,ncrop); % Crop for displaying convenience
  norma_val = max( norma_val , max(im(:))  ); % update max for displaying normalization

  illus{i} = im; % Append to result
  
end % end generating every synthesis wavelet



% Generate figure:
figure;
for i=1:nb,
  subplot(2,nb,i);
  surf(illus{i}); colormap copper; shading interp;  grid off;
  title(sprintf('phi=%1.2fpi  \ntheta=%1.2fpi',phis(i)/pi,thetas(i)/pi));
  subplot(2,nb,i+nb);
  imshow(rsimg(illus{i},'band',norma_val));
end


disp('End of script.');
