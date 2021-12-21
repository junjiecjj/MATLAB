P = peaks(20);
X = repmat(P,[5 10]);
figure(1);
imagesc(X)

Y = fft2(X);
figure(2);
imagesc(abs(fftshift(Y)))