function [C,K] = encryptionf(A, ni1 , ni2, ni3, N1, N2, N3, Nn, alpha)
%
% A = imread('lena.ppm');
% imshow(A,[]);
% A = double(A);
mv = 128;
R = A(:,:,1)-mv;
G = A(:,:,2)-mv;
B = A(:,:,3)-mv;

% ni1 = [16,8,32,64,32,16,32,8,16,32];
% ni2 = [8,8,16,16,32,32,64,8,16,32,16,8];
% ni3 = [16,32,16,8,16,64,32,8,32,8,8,16]
% N1 = 8; N2 = 12; N3 =  6; N4 = 8; N5 = 10;


R1 = bakerN(R,ni1,N1);
G1 = bakerN(G,ni2,N2);
B1 = bakerN(B,ni3,N3);
% figure;
% subplot(131); imshow(R1,[]);
% subplot(132); imshow(G1,[]);
% subplot(133); imshow(B1,[]);



L = sqrt(R1.^2+G1.^2+B1.^2);
theta = angle(R1+1i*G1);
theta(theta<0) = theta(theta<0)+pi*2;
theta = bakerN(theta,ni3,N3);
phi = acos(B1./L); % Cartissian to spherical coordinates
% figure;
% subplot(131); imshow(L,[]);
% subplot(132); imshow(theta,[]);
% subplot(133); imshow(phi,[]);

K = theta/(pi*2);


I1 = L.*cos(phi);
I2 = L.*sin(phi);

Hc_r = I1;
Hc_i = I2;

for nn = 1:length(Nn)

K1 = K;
for k = 1:Nn(nn)
    K1 = alpha*K1.*(1-K1);
    K1 = bakerN(K1,ni3,1);    
end


Hc_r = Hc_r.*(1+0.8*cos(K1*pi*2));
Hc_i = Hc_i./(1+0.6*sin(K1*pi*2));

ReC1 = Hc_r.*cos(K1*pi*2)-Hc_i.*sin(K1*pi*2);
ImC1 = Hc_r.*sin(K1*pi*2)+Hc_i.*cos(K1*pi*2);

% K2 = K1;
% for k = 1:Nn(nn);
%     K2 = alpha*K2.*[1-K2];
% end

ReC1 = ReC1.*(1+0.8*cos(K1*pi*2));
ImC1 = ImC1./(1+0.6*sin(K1*pi*2));

Hc_r = fht2(ReC1);
% HC_r = real(HC_r)+imag(HC_r);
Hc_i = fht2(ImC1);
% HC_i = real(HC_i)+imag(HC_i);
end
% K2 = K;
% for k = 1:N5;
%     K2 = alpha*K2.*[1-K2];
% end
% 
% 
% ReC2 = HC_r.*cos(K2*pi*2)-HC_i.*sin(K2*pi*2);
% ImC2 = HC_r.*sin(K2*pi*2)+HC_i.*cos(K2*pi*2);
% 
% Hc_r = fht2(ReC2);
% % Hc_r = real(Hc_r)+imag(Hc_r);
% Hc_i = fht2(ImC2);
% % Hc_i = real(Hc_i)+imag(Hc_i);

C(:,:,1) = Hc_r;
C(:,:,2) = Hc_i;
C(:,:,3) = zeros(size(Hc_r));
% figure; imshow(C,[]);



