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
%   ellipse3.m      (No dependency)
%   ellipse3_back.m (No dependency)
%   anglewrap.m     (No dependency)

% ----------------------------------------------------------------- %
% This script illustate the color 1D analytic signal
% ----------------------------------------------------------------- %
clear ;

% ----------------------------------------------------------------- %
% Create synthetic varying elliptical features:
% ----------------------------------------------------------------- %
res=4; %  change resolution; (4 for high res, 1 for normal)
K = res*100;
K2 = floor(K/2);
N = 3*K ;
oK = ones(1,K);
windoK = 0.5+0.5*cos((2*pi/K)*((1:K)-K/2)) ;

t = 0:N-1;

%  Define theoretical time-varying ellipse parameters:
th_w    =     [  0.3*oK  ,  linspace(0.3,0.5, K  )  ,  0.5*oK          ]/res; % instant frequency
th_phi  = th_w.*t; % instant phase
th_ka   = 0.5*[  windoK  ,  linspace( 0 , 1 ,K+K2)  ,  windoK(K2+1:end)  ];
th_la   =     [  0.5*oK  ,  linspace(0.5, 1 , K  )  ,  1*oK            ];
th_a1   = linspace(  0   , 2*pi , N ); 
th_a2   = linspace( pi/2 ,   0  , N );
th_a3   = linspace(-pi/2 , pi/2 , N );

th_ka = th_ka + 0.01; % avoid instabilities of all angles due to ka==0
th_la = th_la - 0.01; % avoid instabilities of angle a3 due to la==1


%  Convert to an RGB 1D input signal:
[r,g,b,rh,gh,bh]=ellipse3_back(th_ka,th_la,th_phi,th_a1,th_a2,th_a3);
% Re-convert to retrieve the original elliptical features with proper angle wrapping:
[th_ka,th_la,th_phi,th_a1,th_a2,th_a3]=ellipse3(r,g,b,rh,gh,bh);

% ----------------------------------------------------------------- %
%  Estimate color analytic signal 
% ----------------------------------------------------------------- %
% Process FFT-domain Hilbert transform to every color channel:
H = ifftshift(  -1i * sign((-floor(N/2):ceil(N/2)-1)/N)  ); % sampled Fourier response of the Hilbert transform
rh2 = real(ifft(  fft(r) .* H  )); % FFT-domain Hilbert transform
gh2 = real(ifft(  fft(g) .* H  )); % FFT-domain Hilbert transform
bh2 = real(ifft(  fft(b) .* H  )); % FFT-domain Hilbert transform

% ( Note that [rh,gh,bh] from previous calling of ellipse3_back()
%   already provides the theoretic Hilbert transform for [r g b].
%   However the goal here is to test the model's consistency 
%   when using the experimental Hilbert transform [rh2 gh2 bh2].  )

% ----------------------------------------------------------------- %
% Get experimentally estimated elliptical features:
% ----------------------------------------------------------------- %
[ka,la,phi,a1,a2,a3]=ellipse3(r,g,b,rh2,gh2,bh2);


% ----------------------------------------------------------------- %
% Plot comparatively:
% ----------------------------------------------------------------- %
%% 1D Plot of color analytic signal
figure;
% Plot 3 channels and Amplitude:
subplot(511);plot( t , th_ka ,'c','Linewidth',2);hold all; % theo. amp
             plot(t,r,'Color',[1, 0 ,0]);hold all; % red
             plot(t,g,'Color',[0,0.7,0]);hold all; % green
             plot(t,b,'Color',[0, 0 ,1]);hold all; % blue
             plot( t , ka ,':k'); % estimated amplitude
             title('RGB channels / amplitude (estim. in dotted black, theo. in cyan)');
tmp = ones(40,1);
% Plot color BITMAP of the input signal:
btmp = zeros(40,numel(r),3);  btmp(:,:,1)=tmp*r;  btmp(:,:,2)=tmp*g;  btmp(:,:,3)=tmp*b;
subplot(512);imshow(  0.5+0.5*btmp  );
             title('Bitmap of the color 1D signal');
subplot(513);plot( t , th_la ,'c','Linewidth',2);hold all;
             plot( t , la ,':k');
             title('lambda (estimated in dotted black, theo. in cyan)');
subplot(514);plot( t , anglewrap(th_phi,'[-pi;pi]') , 'c','Linewidth',2);hold all;
             plot( t , phi  , ':k' );
             axis([t(1) t(end) -pi pi]);
             title('Instant phase (estimated in dotted black, theo. in cyan)');
subplot(515);plot( t , anglewrap(th_a1,'[0;2pi]') ,'Color' , [0,1.0,1.0] ,'Linewidth',2);hold all;
             plot( t , anglewrap(th_a2,'[0;2pi]') ,'Color' , [0,0.7,1.0] ,'Linewidth',2);hold all;
             plot( t , anglewrap(th_a3,'[0;2pi]') ,'Color' , [0,0.7,0.7] ,'Linewidth',2);hold all;
             plot( t , anglewrap(a1,'[0;2pi]') , ':k' );hold all;
             plot( t , anglewrap(a2,'[0;2pi]') , ':k' );hold all;
             plot( t , anglewrap(a3,'[0;2pi]') , ':k' );
             axis([t(1) t(end) 0 2*pi]);
             title('Ellipse angles a1 a2 a3 (Estimated in dotted black, theo. in cyan)');

% %%  3D PLOT of color signal
% figure(2);clf(2);title('3D plot of the color 1d signal');
% for i=1:length(t)-1,
  % line(r(i:i+1),g(i:i+1),b(i:i+1),'Color', 0.5+0.5*[r(i),g(i),b(i)],'LineWidth',3 );
% end

disp('End of script.');
