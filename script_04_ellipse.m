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
%   ellipse3.m  (No dependency)


% ----------------------------------------------------------------- %
% Script that illustrates the ellipse drawn by a color sinusoid
% ----------------------------------------------------------------- %


wt = 0:0.1:2*pi;% pulsation times time = varying phase coordinate
wt = [wt,2*wt(end)-wt(end-1)]; % add a last point to close the drawn line

% Define color 1D Fourier atom coefficients:
As = [ 0.70 , 0.18 , 0.36 ];     % marginal amplitudes
Ps = [-0.63 ,-0.10 ,-0.03 ]*pi; % marginal phases

% Process color oscillation:
r = As(1)*cos(wt+Ps(1));
g = As(2)*cos(wt+Ps(2));
b = As(3)*cos(wt+Ps(3));

% Process ellipse parameters:
[ka,la,ph,a1,a2,a3]=ellipse3( As(1)*cos(Ps(1)) , ...
                              As(2)*cos(Ps(2)) , ...
                              As(3)*cos(Ps(3)) , ...
                              As(1)*sin(Ps(1)) , ...
                              As(2)*sin(Ps(2)) , ...
                              As(3)*sin(Ps(3))      );

% Note : the actual time-varying phase data is "ph+w*t"
% every other parameter is constant


% ------------------------------------------------------ //
% 3D ELLIPSE 
figure;

for i=1:length(wt)-1,
  c = 0.5+0.5*[r(i),g(i),b(i)]; % get color at this point of the path
  % plot only one small line:
  plot3( r(i:i+1) , g(i:i+1) , b(i:i+1) , 'Color' , c , 'LineWidth' , 5 );
  hold on;
end
w = 0.8;
axis([-w w -w w -w w]);

% Plot a line to show t=0 (phase angle is between this line and the major axis)
plot3( [0;r(1)],[0;g(1)] , [0;b(1)] , 'Color' , [0,0,0] , 'LineWidth' , 1 );
 
% Plot major axis:
tmp = abs(angle(exp(1i*wt)./exp(1i*(-ph)))); % abs diff between wt and -ph
idx = find( tmp==min(tmp) );% find where wt==-ph (apogee)
idx = idx(1);
plot3( [-r(idx);r(idx)],[-g(idx);g(idx)] , [-b(idx);b(idx)] , 'Color' , [0,0,0] , 'LineWidth' , 1 );
% Plot minor axis:
tmp = abs(angle(exp(1i*wt)./exp(1i*(-ph-pi/2)))); % abs diff between wt and -ph-pi/2
idx = find( tmp==min(tmp) );% find where wt==-ph-pi/2 (perigee)
idx = idx(1);
plot3( [-r(idx);r(idx)],[-g(idx);g(idx)] , [-b(idx);b(idx)] , 'Color' , [0,0,0] , 'LineWidth' , 1 );

% Plot marginal ellipses:
plot3( r , g , b*0-w , 'Color' , [0,0,0] , 'LineWidth' , 1 );
plot3( r , g*0-w , b , 'Color' , [0,0,0] , 'LineWidth' , 1 );
plot3( r*0+w , g , b , 'Color' , [0,0,0] , 'LineWidth' , 1 );

% Plot bounding rectangles:
aa = [-w; w; w;-w;-w]; 
bb = [-w;-w; w; w;-w]; 
cc = [-w;-w;-w;-w;-w];
plot3( aa , bb , cc , 'Color' , [0,0,0] , 'LineWidth' , 1 );
plot3( aa , cc , bb , 'Color' , [0,0,0] , 'LineWidth' , 1 );
plot3(-cc , bb , aa , 'Color' , [0,0,0] , 'LineWidth' , 1 );
xlabel('R');ylabel('G');zlabel('B');
title('Color wave drawing an elliptical path in RGB');


% ******************************************************** //
% ********** GRAPHICS ************************************ //
% ******************************************************** //

figure;

% Imshow plane wave:
subplot(121);
nper = 5;
tt = 0:0.1:nper*2*pi;% time scale in seconds
xxx = (tt')*ones(size(tt));
yyy = ones(size(tt'))*tt;
ori = pi/3;
ttt = cos(ori).*xxx + sin(ori).*yyy;
% Process plane wave:
rrr = As(1)*cos(w*ttt+Ps(1));
ggg = As(2)*cos(w*ttt+Ps(2));
bbb = As(3)*cos(w*ttt+Ps(3));
img2 = 0.5+0.5*cimg(rrr,ggg,bbb);
imshow(img2);
title('Directional 2d extension of the color wave');

% Plot 1D SIGNAL :
subplot(122);
plot([r;g;b]');
title('RGB Channels of the color wave');
