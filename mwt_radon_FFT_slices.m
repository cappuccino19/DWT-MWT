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
%
% Subroutine at the end of the file: ii = mat_idx( xx , yy , siz );
%  (Returns 1D index of matrix element (x,y))


%
% [ paths , dims , ang , subpath_idx ] = mwt_radon_FFT_slices( siz , THICKNESS )
%
%  This function generates a set of discrete lines                    % 
%  as lists of 2D coordinates.                                        % 
%  Lines cover a whole 2D-FFT-like matrix, with each line crossing    % 
%  the origin, centered on the matrix.                                % 
%  Matrix is supposed to be obtained from a 2D FFT,                   % 
%  and shifted with fftshift() so that DC component is in the middle. %

%  The discrete lines can be used to perform discrete Radon transform,% 
%  according to:                                                      % 
%   [ Carré P. & Andres E., "Discrete Analytical Ridgelet Transform"  %
%     Elsevier Sig. Proc. 84, 11 (2004) 2165-2173 ]                   % 

% For information, we give here the implementation of the Radon       %
% transform based on the present function:                            %
%   % --------------------------------------------------------------- %
%   % Forward Radon transform:
%   % --------------------------------------------------------------- %
%   [M,N] = size(img); % input image size
%   [paths,dims,ang,subpath_idx] = radon_FFT_slices([M,N],THICKNESS);
%   L = length(dims);  % Number of slices
%   radonp = zeros( max(dims) , L );  % init Radon transform
%   F2D = fftshift(fft2(img));        % 2D FFT 
%   for p=1:L, %  for each Radon projection
%     slice = F2D(paths{p});                        % Fourier slice
%     radonp( 1:dims(p) , p ) = real(ifft(slice))'; % Radon projection
%   end
%   % --------------------------------------------------------------- %
%   % Reverse Radon transform:
%   % --------------------------------------------------------------- %
%   F2D = zeros(M,N); %  Empty Fourier spectrum
%   for p=1:L, %  for each Radon projection
%     slice = fft(in( 1:dims(p) , p ));       % 1D FFT of Radon proj.
%     pat = paths{p};                         % discrete line indices
%     idx = subpath_idx{p};                   % non-overlapping subpath
%     F2D(pat(idx)) = slice(idx) ;            % Set it in 2D spectrum
%   end
%   img = real(ifft2(ifftshift(F2D))); % inverse 2d FFT
%   % --------------------------------------------------------------- %

% This implementation is slightly different from the original work    %
% by Carré & Andrès because:                                          %
%  - It accepts any size for input image                              % 
%    (but perfect reconstruction is conditional)                      % 
%  - the reconstruction method is no longer based on an averaging,    %
%    but on some selection of samples.                                %
%    To this end, a "non-overlapping subset" of samples is processed. %
%    See [ R. Soulard & P. Carré, "Elliptical Monogenic Wavelets for  %
%        the analysis and processing of color images" IEEE TSP 2015 ] %

% Note on perfect reconstruction:                                     %
%                                                                     % 
%  ODD sizes (both lines and columns):  -->  reconstruction is EXACT. % 
%  EVEN sizes (lines OR columns OR both):                             % 
%  Two cases.                                                         % 
%  In the general case:                 --> reconstr. is APPROXIMATE. % 
%                                                     (although good) %
%  However, if the input has a null Fourier                           %
%  spectrum at Nyquist frequencies:     -->  reconstruction is EXACT. % 
%  To ensure exact reconstruction with even size images, one may      % 
%  zero out their spectrum at Nyquist frequencies (last line/column), %
%  which usually does not substantially modify the image.             %

% Note on Radon lines' length:                                        %
%  When it is required that every Radon line's length is the same:    % 
%  1) image size [M,N] must verify M=N=4*K+3                          % 
%  2) naive closed lines must be used (parameter LINE_TYP=0)          % 




% Subroutine for 1d index at the end of the file : 
%  function ii=mat_idx(xx,yy,siz)


function [paths,dims,ang,subpath_idx]=mwt_radon_FFT_slices(siz,THICKNESS)
  %  siz : [M,N] size of FFT (works for any size)
  %  THICKNESS :  Type of discrete line
  %               0: closed naive lines (8-connexity)
  %               1: pythagorean lines (8-connexity)
  %               2: supercover lines (4-connexity)

  %  paths    : list of vectors, each one containing the 1D coordinates
  %             forming one discrete line.
  %  dims     : length of each line
  %  ang      : orientation of each line (radians)
  %  subpath_idx : list of vectors. The p-th vector contains indices of 
  %                the p-th path to be used for non-overlapping reconstruction.
  
  M=siz(1);
  N=siz(2);

  Mo = 2*floor(M/2)+1; %  Consider an alternate odd size ('o' for 'odd')
  No = 2*floor(N/2)+1; %  in case image size is even.

  Mc = ceil(Mo/2);  %  Center coordinate ( 'c' for 'center' ). This is
  Nc = ceil(No/2);  %  the DC-component position when using fftshift().

  

  paths = cell(1,Mo+No-2); %  Init result
  
  %  ---------------------------------------- Define two simple paths % 
  Y1 = [(Nc:-1:1),(N:-1:(Nc+1))];   %  p=1:
  X1 = Mc*ones(1,length(Y1));       %  horizontal path
  X2 = [(Mc:M)    , (1:(Mc-1))   ]; %  p=Mc+Nc-1:
  Y2 = Nc*ones(1,length(X2));       %  vertical path
  paths{   1   } = mat_idx(X1,Y1,siz); %  Convert to "1D indices" for direct
  paths{Mc+Nc-1} = mat_idx(X2,Y2,siz); %  extraction from a 2D matrix.

  %  ---------------------------------------- Define all other paths  % 
  X0 = [   (Mc+1:Mo)  Mo*ones(1,Nc-2) ];  %  Starting points:
  Y0 = [ ones(1,Mo-Mc)   (2:Nc-1)     ];  %  all in lower-left quadrant

  for p=2:(Mc+Nc-2),  %  --- Process path from starting point to origin.

    X = [];           Y = [];           %  Init list of (x,y) coordinate
    x = X0(p-1);      y = Y0(p-1);      %  Init (x,y) point 
    a = x-Mc;         b = y-Nc;         %  Centered starting point
      
    if THICKNESS==0, d=max( abs(a) , abs(b) )/2; end %  Half
    if THICKNESS==1, d=sqrt( a^2   +  b^2   )/2; end %  distance
    if THICKNESS==2, d=( 1+ abs(a) + abs(b) )/2; end %  from center

    while( (x~=Mc) | (y~=Nc) )

      X = [X, x ];    Y = [Y, y ];    %    Append current position.
      %  Update (x,y) so that the area of the triangle [(a,b)(x,y)(0,0)]
      %  is small enough compared to "d":
      aybx = a*(y-Nc)-b*(x-Mc);
      if     ( abs(aybx+b  )<=d ), x=x-1;         %  --> upward
      elseif ( abs(aybx+a  )<=d ),        y=y+1;  %  --> right
      else                         x=x-1; y=y+1;  %  --> up right
      end

    end %  end while
    
    %  Extend the path symmetrically in the opposite quadrant.
    %  (This one goes from the upper right to the lower left quadrant)
    X1 = [ Mc , X(end:-1:1) , -X+Mo+1 ]; % and set it in the standard
    Y1 = [ Nc , Y(end:-1:1) , -Y+No+1 ]; %    "non-shifted" FFT form.
    X2 =   X1    ; %  Define the second path (symmetric), that goes from
    Y2 = No-Y1+1 ; %  upper left to lower right quadrant.
    
    %  ---- This part is useful when image size is even. ---- % 
    idx1 = (X1<=M) & (Y1<=N); %  Crop positions being outside
    idx2 = (X2<=M) & (Y2<=N); %  of real FFT size [1,M]x[1,N]
    %  ------------------------------------------------------ % 

    paths{   p   }=mat_idx(X1(idx1),Y1(idx1),siz); %  Convert to 
    paths{Mo+No-p}=mat_idx(X2(idx2),Y2(idx2),siz); %  1D indices
  end
  
  %  Process angle value for every slice:
  cs= [     0:(Mc-2)        , (Mc-1)*ones(1,No) ,    (Mc-2):-1:1      ];
  ss= [ (1-Nc)*ones(1,Mc-1) ,   (1-Nc):(Nc-1)   , (Nc-1)*ones(1,Mc-2) ];
  ang = atan2( ss , cs );
  
  %  Process local angle values ang2D:
  omegM = [-floor(M/2):ceil(M/2)-1];
  omegN = [-floor(N/2):ceil(N/2)-1];
  w1 = omegM'*ones(1,N);
  w2 = ones(M,1)*omegN;
  ang2D = atan2(w2,w1);
  idx=(ang2D>=pi/2); ang2D(idx)=ang2D(idx)-pi; %  Angle wrapping
  idx=(ang2D<-pi/2); ang2D(idx)=ang2D(idx)+pi; %  Angle wrapping
  
  %  Process best slice index for every FFT coefficient:
  best_slice_idx = zeros(M,N);
  for i=1:M,
    for j=1:N,
      ang_diff = abs( ang - ang2D(i,j) );
      best_slice_idx(i,j) = find( ang_diff==min(ang_diff) , 1 );
    end
  end
  
  %  Process indices of non-overlapping sub-paths "subpath_idx":
  %  Process length of every slice "dims":
  subpath_idx = cell(1,Mo+No-2);
  dims = zeros(1,Mo+No-2);
  for p=1:Mo+No-2,
    best = best_slice_idx(paths{p});
    subpath_idx{p} = find(p==best);
    dims(p) = length(paths{p});
  end
  
function ii=mat_idx(xx,yy,siz)
    %  Return 1D index of matrix element (x,y)
    %  Size of matrix is siz
    ii = xx + siz(1)*(yy-1);
    
