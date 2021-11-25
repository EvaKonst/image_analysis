original = imread('chart.tiff');
ori=original;
original = im2double(original);

blurred = psf(original);
bl = blurred;
blurred = im2double(blurred);

crispfft = fft2(original);
blurredfft = fft2(blurred);

PSFfft = blurredfft ./ crispfft;

figure,
imshow(PSFfft);
title('Απόκριση συχνότητας psf');

figure; 
subplot(1,2,1);imshow(ori,[]),title('original image');
subplot(1,2,2);imshow(bl,[]),title('blurred image');

G=1./PSFfft;

i = 0;
figure
for thresh = 0.01 : 0.05: 0.2
    i = i + 1;
    Gn = zeros(size(G));
    Gn(abs(PSFfft) >= thresh) = G(abs(PSFfft) >= thresh);
    rec_Gn = blurredfft .* Gn;
    rec_p = real(ifft2(rec_Gn));
    mse = immse(ori,uint8(rec_p));
    subplot(2,2,i),imshow(rec_p),title(['Threshold of Pseudo-inverse filtering = , mse =',num2str(thresh),mse]);
end

figure
subplot(3,2,1),imshow(ori),title('original image');
subplot(3,2,2),imshow(rec_p),title('Recovered by threshold-inverse filter')