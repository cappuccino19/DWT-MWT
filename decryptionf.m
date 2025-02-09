function iA = decryptionf(C, K, ni1 , ni2, ni3, N1, N2, N3, Nn, alpha)
%

Hc_r = C(:,:,1);
Hc_i = C(:,:,2);

for nn = length(Nn):-1:1
ReC2 = fht2(Hc_r);
% ReC2 = real(ReC2)+imag(ReC2);
ImC2 = fht2(Hc_i);
% ImC2 = real(ImC2)+imag(ImC2);

K1 = K;
for k = 1:Nn(nn)
    K1 = alpha*K1.*(1-K1);
    K1 = bakerN(K1,ni3,1);
end


% K2 = K1;
% for k = 1:Nn(nn);
%     K2 = alpha*K2.*[1-K2];
% end

ReC2 = ReC2./(1+0.8*cos(K1*pi*2));
ImC2 = ImC2.*(1+0.6*sin(K1*pi*2));

Hc_r = ImC2.*sin(K1*pi*2)+ReC2.*cos(K1*pi*2);
Hc_i = ImC2.*cos(K1*pi*2)-ReC2.*sin(K1*pi*2);

Hc_r = Hc_r./(1+0.8*cos(K1*pi*2));
Hc_i = Hc_i.*(1+0.6*sin(K1*pi*2));

end
% ReC1 = fht2(HC_r);
% % ReC1 = real(ReC1)+imag(ReC1);
% ImC1 = fht2(HC_i);
% % ImC1 = real(ImC1)+imag(ImC1);
% 
% K1 = K;
% for k = 1:N4;
%     K1 = alpha*K1.*[1-K1];
% end

I1 = Hc_r;
I2 = Hc_i;

L = abs(I1+1i*I2);
phi = angle(I1+1i*I2);
theta = K*pi*2;
theta = ibakerN(theta,ni3,N3);
B1 = L.*cos(phi);
G1 = L.*sin(phi).*sin(theta);
R1 = L.*sin(phi).*cos(theta);

R = ibakerN(R1,ni1,N1);
G = ibakerN(G1,ni2,N2);
B = ibakerN(B1,ni3,N3);
mv = 128;
iA(:,:,1) =R+mv;
iA(:,:,2) =G+mv;
iA(:,:,3) =B+mv;