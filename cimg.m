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

% Multi-valued matrices utility
% (No dependency)

function v=cimg(varargin)

% Creates a MxNx3 color matrix from 1 or 3 scalar ones

if nargin==1 % copy the same scalar matrix in the 3 color channels
  r = varargin{1};
  g = r;
  b = r;
elseif nargin==3 
  r = varargin{1};
  g = varargin{2};
  b = varargin{3};
else
  fprintf('cimg(): 1 or 3 args expected');
end
% make a 3D vector valued MxNx3 matrix 'v' from 3 MxN matrices 'r', 'g', 'b'. 
v = zeros(size(r,1),size(r,2),3);
v(:,:,1) = r;
v(:,:,2) = g;
v(:,:,3) = b;
