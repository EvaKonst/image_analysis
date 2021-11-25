function RGB_adapthisteq()

I = load('barbara.mat');
I = cell2mat(struct2cell(I));

%display original image
subplot(2, 3, 1);
imshow(I, []);
caption = sprintf('Image Before RGB Adaptive Histogram Equalization');
title(caption);
    
%extract the red, green, and blue color channels.
red = I(:, :, 1);
green = I(:, :, 2);
blue = I(:, :, 3);
	
%perform histogram equalization on red channel:
subplot(2, 3, 4);
red = adapthisteq(red);
imshow(red, []); 
caption = sprintf('Histogram equalization of Red Image');
title(caption);

%perform histogram equalization on green channel:
subplot(2, 3, 5);
green = adapthisteq(green);
imshow(green, []); 
caption = sprintf('Histogram equalization of Green Image');
title(caption);

%perform histogram equalization on blue channel:
subplot(2, 3, 6);
blue = adapthisteq(blue);
imshow(blue, []); 
caption = sprintf('Histogram equalization of Blue Image');
title(caption);

%reconstruct the image 
I(:,:,1)= red;
I(:,:,2)= green;
I(:,:,3)= blue;

subplot(2, 3, 3);
imshow(I, []);
caption = sprintf('Image After RGB Adaptive Histogram Equalization');
title(caption);

end