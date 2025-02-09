function X = fht2(x)
[M,N] = size(x);
X = fft2(x)/sqrt(M*N);
X = real(X)+imag(X);