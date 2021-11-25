function HSI_Histeq()

I = load('barbara.mat');
I = cell2mat(struct2cell(I));

%display original image
subplot(1, 2, 1);
imshow(I, []);
caption = sprintf('Image Before HSI Histogram Equalization');
title(caption);

%convert color image into HSI image
I = rgb2hsv(I);

%perform total histogram equalization on intensity component
intensity = I(:, :, 3);
	
%perform histogram equalization on component of intensity:
intensity = histeq(intensity);

%convert HSI image back to RGB image
I(:,:,3)= intensity;
I = hsv2rgb(I);

subplot(1, 2, 2);
imshow(I, []);
caption = sprintf('Image After HSI Histogram Equalization');
title(caption);

end