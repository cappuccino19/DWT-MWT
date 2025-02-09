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

% Routines for rendering color bitmap illustrations 
% from such data as amplitudes, phase angles, orientation angles etc.

% Dependencies:
%   anglewrap.m (No dependency)
%   cimg.m      (No dependency)

function im=rsimg(data,typ,varargin)
% -- im=rsimg(data,typ,varargin) --------------------------------- %
%    renders a color bitmap 'im' to illustrate 'data'              %
%                                                                  %
% -- INPUT ------------------------------------------------------- %
% 'data': a scalar or 3D vector valued MxN matrix                  %
%                                                                  %
% 'typ' (type of data):                                            %
%                                                                  %
% - 'amp' : positive scalar                                        %
%           -> will be normalized by 'mx' (varargin).              %
% - 'band': relative scalar or 3D vector data                      %
%           -> will be centered and normalized by 'mx' (varargin). %
% - 'phaz': phase angle                                            %
%           -> will be first wrapped into [-pi/2;pi/2]             %
%           and then 'folded' in [0;pi/2]. Will then be displayed  %
%           as a hue data in the HSV color system.                 %
%           The brightness will be controlled                      %
%           by the additional MxN matrix 'mask' (varargin).        %
% - 'dir' : direction angle in [-pi/2;pi/2]                        %
%           -> will be wrapped in [-pi/2;pi/2] and displayed       %
%           as a hue data in the HSV color system.                 %
%           The brightness will be controlled                      %
%           by the additional MxN matrix 'mask' (varargin).        %
%                                                                  %
% 'varargin': depending on 'typ', may be:                          %
%             - nothing,                                           %
%             - a scalar positive value 'mx',                      %
%             - a MxN scalar matrix in [0;1] 'mask'                %
% ---------------------------------------------------------------- %
% Constant:
col = size(data,3)==3 ; % is the matrix 3D valued?
% Test of arguments:
if ~col & size(data,3)~=1 
	fprintf('rsimg: 1st arg must be a MxN or MxNx3 matrix');
	return;
end
if ~strcmp(typ,'amp') && ~strcmp(typ,'band') && ~strcmp(typ,'phaz') && ~strcmp(typ,'dir') 
	fprintf('rsimg: 2nd arg must be ''amp'' or ''band'' or ''phaz'' or ''dir''');
	return;
end
if (strcmp(typ,'amp') || strcmp(typ,'phaz') || strcmp(typ,'dir')) && col 
	fprintf('rsimg: 1st arg must be scalar valued in ''amp'', ''phaz'' and ''dir'' modes');
	return;
end
nb_of_opt_args = nargin-2;
switch nb_of_opt_args % define max value 'mx' and the HSV saturation/value matrices. 
case 0, mx = max(max(max(abs(data)))); % default normalization constant
 		satu=ones(size(data,1),size(data,2)); % default saturation
        valu = satu; % default value
case 1, mx=varargin{1}; 
  		satu=varargin{1}; % custom saturation
        valu = ones(size(satu)); % default value
case 2, mx=varargin{1}; 
		satu=varargin{1}; % custom saturation
        valu = varargin{2}; % custom value
otherwise  fprintf('rsimg: this function cannot take more than 4 arguments');
        return;
end % note that only one of (mx,mask) will be used, depending on 'typ'
% ---------------------------------------------------------------- %
% Routines:
% ---------------------------------------------------------------- %
switch typ
case 'amp' , data=abs(data);
             if mx~=0, data=data/mx; end;
             im = 1 - cimg(data,data,data); % "white background"
             %im = cimg(data,data,data); % "black background"
case 'band', if mx~=0, data=data/mx; end;
             if ~col,  data = cimg(data,data,data);  end;
             im = 0.5+0.5*data;
case 'phaz', h = abs(anglewrap(data,'[-pi/2;pi/2]')); % fold data into [0;pi/2]
%						h = 0.7*h/(pi/2); % [0;0.7] <-> red to blue hue
%						im = hsv2rgb(cimg(h,mask,ones(mask)));
             % new "red to blue" colormap for phase :
             ired = (h<pi/4);
             iblu = ~ired;
             h(ired) = 0.02*pi - (0.15*pi)*h(ired)/(pi/4);
             h(iblu) = -0.13*pi - (0.23*pi)*(h(iblu)-pi/4)/(pi/4);
             h = anglewrap(h,'[0;pi]')/pi;
             im = hsv2rgb(cimg(h,satu,valu));
case 'dir' , h = anglewrap(data,'[0;pi]')/pi;
             im = hsv2rgb(cimg(h,satu,valu));
end;

