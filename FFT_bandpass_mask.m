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


% Creates an MxN grid of 2d Fourier response
% for an isotropic linear phase band-pass filter 
% which gain varies in [0;1].
% First sample is the "DC coordinate" (no 'fftshift' done).


% Dependencies:
%   FFT_radial.m

function [mask] = FFT_bandpass_mask(siz,rad_bounds)
    
    RHO = FFT_radial(siz);
    mask = RHO;  
    
	a1 = rad_bounds(1);
	a2 = rad_bounds(2);
	a3 = rad_bounds(3);
	a4 = rad_bounds(4);

    mask(RHO<=a1) = 0;
    idx = RHO>a1 & RHO<a2;
    mask(idx) = 0.5 + 0.5*sin(  -(pi/2) + pi*(RHO(idx)-a1)/(a2-a1)  );
    mask(RHO>=a2 & RHO<=a3) = 1;
    idx = RHO>a3 & RHO<a4;
    mask(idx) = sin(  (pi/2)*(  1  -  (RHO(idx)-a3)/(a4-a3)  )  );
    mask(RHO>=a4) = 0;
    
end

    
