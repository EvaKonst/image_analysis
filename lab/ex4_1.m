%read the image and add white gaussian noise 
Iorig = imread('chart.tiff');
Idouble = im2double(Iorig);
%get the dimensions of the image
[rows, columns] = size(Iorig);

varI = std2(Idouble)^2;
sigma_noise = sqrt(varI/10^(10/10));
N = sigma_noise*randn(size(Idouble));
I = Idouble+N;


figure
imshow(I);
title('Image with Added Gaussian Noise');

K = wiener2(I,[3 3],0.0085);

figure
imshow(K);
title('Image with Noise Removed by Wiener Filter');

J= wiener2(I,[3 3]);
figure
imshow(J);
title('Restoration of Blurred Noisy Image (Not Estimating Noise Power)')

