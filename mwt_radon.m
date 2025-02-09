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

%
% Monogenic wavelet transform based on Gabor like 1D wavelets
% in the discrete Radon domain, as proposed in 
% [Soulard et Carré IEEE TSP 2015, 'Elliptical monogenic...'].
% (The normalization method may slightly differ from the original source 
%  code, for consistency with 'mwt_radial.m')
%
% No pyramid setting (undecimated only)
%
% For even-sized images, the filterbank reconstruction is approximative.
%

% Dependencies:
%
% 'mwt_radon_FFT_slices.m' (No dependency)
%   Extracts sample selection drawing lines in the 2d Fourier domain
% 'mwt_radon_SUAWTfilters' (subroutine is at the end of the file)
%   Gaussian-like 1d wavelet (only one wavelet design available)

function out = mwt_radon(opt,in,L,noRzHF,norma)
% opt : 'a' for analysis, 's' for 'synthesis'
% in  : MxN 2d matrix input image or (L+1,3)-cell-array input MWT
% L   : integer - number of scales
% norma : 'true': subbands are normalized by the energy of equiv. filters
%         'false' : equiv. filters have freq. resp. in [0;1]
% noRzHF : 'true' : the Riesz transform is not performed at 1st scale
%                   to enhance the decay of monogenic amplitude.
%          'false': classical MWT



if opt=='a', % ----------------- MWT Analysis --------------------------- %

  lowfreqband = in; 
  
elseif opt=='s', % ----------------- MWT Synthesis ---------------------- %

  lowfreqband = in{L+1,1};
  
else % ------------------------------------------------------------------ %
  fprintf('radonMWT - bad arg.: 1st arg. must be ''a'' or ''s''.\n'); return;
end

[M,N,tmp]=size(lowfreqband); % get image size 

if(M/2==floor(M/2) | N/2==floor(N/2)), % Size warning
  fprintf('mwt_radon() warning: size is even -> approx. reconstruction.\n');
end

%%%%%%%%%%  Prepare discrete lines for all Radon transforms %%%%%%%%%%
THICKNESS = 0; %  0=Naive lines  1=Pythagorean  2=Supercover
[paths,dims,ang,subpath_idx]=mwt_radon_FFT_slices([M,N],THICKNESS);
% --- RADON TRANSFORM (1D Fourier domain).
% In this wavelet transform, for computing efficiency, 
% the Radon algorithm is used partially. 
% 2d paths are obtained from 'radon_FFT_slices.m', and 
% the 2d discrete Fourier slices are handled as "F(paths{p})". 
% This way we can skip the unnecessary inverse and forward 1D FFT's, 
% and all the calculation is done in the Fourier domain.
%
% 'a': (analysis)  Radon transform of input image 
% 's': (synthesis) Radon transform of low freq. band 
%
%   (as low freq. part to be updated at each scale):
F = fftshift(fft2( lowfreqband )); %  2D FFT 
rad  = zeros( max(dims) , length(dims) );
for p=1:length(dims),
  rad( 1:dims(p) , p ) = F(paths{p}).'; %  Record p-th Fourier slice 
end                              % (no iFFT for computational efficiency)
clear F;

%------------------------------------------------------------------------ %
if opt=='a', % ----------------- MWT Analysis --------------------------- %
%------------------------------------------------------------------------ %

% 'in'  is a 2d matrix (input greyscale image)
% 'out' will be a (L+1,3) cell array (output MWT)

out = cell(L+1,3); % Init Wavelet transform
for scal=1:L, %  for each scale
  FFTprim = zeros(M,N); %  Empty Fourier spectrum for primary part
  FFTriz1 = zeros(M,N); %  Empty Fourier spectrum for x-Riesz part
  FFTriz2 = zeros(M,N); %  Empty Fourier spectrum for y-Riesz part
  
  for p=1:length(dims),  %  for each Radon projection
    K = dims(p);
    %  Forward Gabor-like 1D transform:
    
    [H,G,Gh,cst]=mwt_radon_SUAWTfilters(K,scal);
    
    if norma,
      H = H*2; % 
      G = G/cst; %  filter normalization
      Gh=Gh/cst; %  filter normalization
    end
    G = G/sqrt(2); 
    Gh=Gh/sqrt(2); 
     
    lo = rad(1:K,p);
    rad(1:K,p) = lo.*H;
    slice_prim = lo.*G ;
    slice_hilb = lo.*Gh;
    slice_riz1 = cos(ang(p))*slice_hilb;
    slice_riz2 = sin(ang(p))*slice_hilb;

    %  Inverse Radon transform (1st part):
    pat = paths{p};                         %  discrete line indices
    idx = subpath_idx{p};                   %  non-overlapping subpath
    FFTprim(pat(idx)) = slice_prim(idx).';
    FFTriz1(pat(idx)) = slice_riz1(idx).';
    FFTriz2(pat(idx)) = slice_riz2(idx).';
  end %  end for "p"
    
  %  Inverse Radon transform (2nd part):
  out{scal,1} = real(ifft2(ifftshift(FFTprim))); % scal-th scale's Primary part
  out{scal,2} = real(ifft2(ifftshift(FFTriz1))); % scal-th scale's x-Riesz part
  out{scal,3} = real(ifft2(ifftshift(FFTriz2))); % scal-th scale's y-Riesz part
  
  % handle noRzHF parameter:
  if noRzHF && scal==1,
    out{1,1} = out{1,1} * sqrt(2);
    for k=2:3,
      out{1,k} = out{1,k} * 0;
    end
  end
  
  
end %  end for "scal"
clear FFTprim FFTriz1 FFTriz2

%------------------------------------------------------------------------ %
else % ------------------------- MWT Synthesis -------------------------- %
%------------------------------------------------------------------------ %

% 'in'  is a (L+1,3) cell array (input MWT) 
% 'out' will be a 2d matrix (output greyscale image)
%       (iteratively built in variable 'lowfreqband')

% This loop updates the radon transform 'rad' of the image to reconstruct
for scal=L:-1:1, %  for each scale
  %  Go into Radon domain for scale 'scal':
  FFTprim = fftshift(fft2(  in{scal,1}  )); %  2D FFT of primary part
  FFTriz1 = fftshift(fft2(  in{scal,2}  )); %  2D FFT of x-Riesz part
  FFTriz2 = fftshift(fft2(  in{scal,3}  )); %  2D FFT of y-Riesz part
    
  for p=1:length(dims),  %  for each Radon projection
    K = dims(p);
    HFprim = FFTprim(paths{p}).'; %  Radon Transform of primary part
    HFriz1 = FFTriz1(paths{p}).'; %  Radon Transform of x-Riesz part
    HFriz2 = FFTriz2(paths{p}).'; %  Radon Transform of y-Riesz part
    HFhilb = (HFriz1*cos(ang(p)) + HFriz2*sin(ang(p))); % Hilbert
    
    %  inverse Gabor-like 1D transform:
    [H,G,Gh,cst]=mwt_radon_SUAWTfilters(K,scal);
    if norma,
      H = H/2; 
      G = G*cst; %  filter normalization
      Gh=Gh*cst; %  filter normalization
    end
    G = G*sqrt(2); 
    Gh=Gh*sqrt(2); 
    % Handle noRzHF parameter:
    if noRzHF && scal==1,
      rad(1:K,p) = rad(1:K,p).*H + HFprim.*G/sqrt(2) ;
    else      
      rad(1:K,p) = rad(1:K,p).*H + (HFprim.*G - HFhilb.*Gh)/2 ; % general reconstruction method
    end
    
  end
end
clear FFTprim FFTriz1 FFTriz2

%------------------------------------------------------------------------ %
end % end if 'opt' 
%------------------------------------------------------------------------ %

%
% --- Inverse RADON transform to retrieve 'lowfreqband': 
%
F = zeros(M,N);                             % Empty Fourier spectrum
for p=1:length(dims), %  for each Radon projection
  slice = rad(1:dims(p),p);
  pat = paths{p};                           % Discrete line indices
  idx = subpath_idx{p};                     % Non-overlapping subpath
  F(pat(idx)) = slice(idx).';               % Fill spectrum with slices
end
lowfreqband = real(ifft2(ifftshift(F)));    % Inverse FFT

% Record 'lowfreqband' as:
if opt=='a', % MWT Analysis
  out{L+1} = lowfreqband; % The low-frequency band of output MWT
else % MWT Synthesis
  out = lowfreqband;      % The reconstructed output image
end 
% End of main function.


% ----------------------------------------------------------------------- %
% ----------     SUBROUTINE     ----------------------------------------- %
% ----------------------------------------------------------------------- %
function [H,G,Gh,cst]=mwt_radon_SUAWTfilters(K,scal)

% Fourier domain 1d wavelet filters 
% & associated experimentally measured normalization constants

  sig = 2^(scal-2);
  w = ifftshift(  (-floor(K/2):ceil(K/2)-1)*2*pi/K  )';
  H  =  exp( -((w*sig).^2)/2 ); % Gaussian      low-pass filter
  G  =  sqrt( 1 - H.^2 );       % Complementary high-pass filter
  Gh = -1i*sign(w).*G;          % Hilbert       high-pass filter
  % Experimentally measured normalization constants:
  csts = [ 0.7931479835;...
           1.0767700002;...
           0.9940407926;...
           0.9643640140;...
           0.9572680992;...
           0.9555182992;...
           0.9551657926;...
           0.9568378006     ];
  if scal<=length(csts),
    cst = csts(scal);
  else
    cst = csts(end);
  end

