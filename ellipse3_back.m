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
% (No dependency)
% see also 'ellipse3.m' 
%

function [varargout]=ellipse3_back(ka,la,phi,a1,a2,a3)
  % Returns 6D Cartesian coordinates from ellipse parameters
  % (if only 2 outputs specified in call, two color matrices are returned)
  ca1 = cos(a1); % > 0
  sa1 = sin(a1);
  ca2 = cos(a2); % > 0
  sa2 = sin(a2);
  ca3 = cos(a3);
  sa3 = sin(a3);

  % Retrieve semi-major and semi-minor axes:
  r_plus  = ka.*sqrt(1+la);
  r_minus = ka.*sqrt(1-la);
  % Retrieve 3d apogee from back rotations by alpha and beta:
  apo1x = r_plus.*ca1.*ca2;
  apo1y = r_plus.*sa1.*ca2;
  apo1z = r_plus.*sa2;
  % Retrieve 3d perigee from back rotations by alpha, beta and theta:
  apo2x = r_minus.*( -sa1.*ca3 - ca1.*sa2.*sa3 );
  apo2y = r_minus.*(  ca1.*ca3 - sa1.*sa2.*sa3 );
  apo2z = r_minus.*(  ca2.*sa3 );
  % Retrive separate Fourier coefficients:
  Fx = (apo1x + 1i*apo2x).*exp(1i*phi);
  Fy = (apo1y + 1i*apo2y).*exp(1i*phi);
  Fz = (apo1z + 1i*apo2z).*exp(1i*phi);
  x=real(Fx); xh=imag(Fx);
  y=real(Fy); yh=imag(Fy);
  z=real(Fz); zh=imag(Fz);

  if nargout==6
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
    varargout{4} = xh;
    varargout{5} = yh;
    varargout{6} = zh;
  elseif nargout==2
    v = zeros(size(x,1),size(x,2),3);
    v(:,:,1) = x;
    v(:,:,2) = y;
    v(:,:,3) = z;
    varargout{1} = v;

    v = zeros(size(x,1),size(x,2),3);
    v(:,:,1) = xh;
    v(:,:,2) = yh;
    v(:,:,3) = zh;
    varargout{2} = v;

  else
    fprintf('ellipse_back(): 2 or 6 output args expected.\n');
  end
 