%
% This source code is freely distributed from the "colormonogenic" website:
% http://xlim-sic.labo.univ-poitiers.fr/projets/colormonogenic/
% published in 2018,
% which presents the main research results by 
% Raphaël Soulard & Philippe Carr?
% from the XLIM Laboratory (UMR CNRS 7252),
% University of Poitiers, France.
%
% Author: R. Soulard.
%

%
% Ellipse parameters according to [Soulard et Carr?IEEE TSP 2016]
% (No dependency)

function [ka,la,phi,a1,a2,a3]=ellipse31(varargin)
  % Conversion from cartesian coordinates to ellipse parameters
  %
  %  input :   x , y , z , xh , yh , zh   (MxN   matrices)
  %    or :   cimg(x,y,z) , cimg(xh,yh,zh) (MxNx3 matrices)
  if nargin==6 
    x  = varargin{1};
    y  = varargin{2};
    z  = varargin{3};
    xh = varargin{4};
    yh = varargin{5};
    zh = varargin{6};
  elseif nargin==2 
    xyz = varargin{1};
    xyzh= varargin{2};
    x = xyz(:,:,1);
    y = xyz(:,:,2);
    z = xyz(:,:,3);
    xh= xyzh(:,:,1);
    yh= xyzh(:,:,2);
    zh= xyzh(:,:,3);
  else
    fprintf('ellipse() : bad argument!\n');
  end
  
  Ax2 = x.^2+xh.^2;
  Ay2 = y.^2+yh.^2;
  Az2 = z.^2+zh.^2;
  Ax = sqrt(Ax2);
  Ay = sqrt(Ay2);
  Az = sqrt(Az2);
  Px = atan2(xh,x);
  Py = atan2(yh,y);
  Pz = atan2(zh,z);

  Z2 = (x+1i*xh).^2 + (y+1i*yh).^2 + (z+1i*zh).^2;
  phi = atan2(imag(Z2),real(Z2))/2;
  
  idx = Ax.*cos( Px - phi ) < 0;
  phi(idx) = phi(idx)+pi;
  phi( phi>pi ) = phi( phi>pi ) - 2*pi;
  
  apo1x = Ax.*cos(Px-phi); % Apogee = "a(-phi)"  / apo1x > 0
  apo1y = Ay.*cos(Py-phi);
  apo1z = Az.*cos(Pz-phi);
  
  apo2x = Ax.*sin(Px-phi); % Perigee = "a(-phi-pi/2)"
  apo2y = Ay.*sin(Py-phi);
  apo2z = Az.*sin(Pz-phi);

  % Find rotation angles so that 1st apogee fits the x-axis:
  a1 = atan(apo1y./apo1x); % a1 is in [-pi/2;pi/2] since apo1x > 0
  a2 = atan(apo1z./sqrt(apo1x.^2+apo1y.^2)); % a2 is in [-pi/2;pi/2]
  
  % Rotate 2nd apogee by [-alph,-bet] to find theta:
  ca = cos(a1);      sa = sin(a1);
  cb = cos(a2);      sb = sin(a2);
  by =     -sa.*apo2x +     ca.*apo2y             ;
  bz = -sb.*ca.*apo2x - sb.*sa.*apo2y + cb.*apo2z ;
  a3 = atan2(bz,by); % a3 is in [-pi;pi]
  
  % Process amplitude and linearity:
  A2 = Ax.^2 + Ay.^2 + Az.^2; % = r_plus.^2 + r_minus.^2
  ka = sqrt(A2/2);
  la = abs(Z2)./A2; % = ( r_plus.^2 - r_minus.^2 )./A2
  la( ka==0 ) = 1;                        % ill-defined cases for linearity
   