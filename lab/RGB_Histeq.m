function RGB_Histeq()

I = load('barbara.mat');
I=cell2mat(struct2cell(I));

%display original image
subplot(3, 3, 1);
imshow(I, []);
caption = sprintf('Image Before RGB Histogram Equalization');
title(caption);
    
%extract the red, green, and blue color channels.
red = I(:, :, 1);
green = I(:, :, 2);
blue = I(:, :, 3);
	
%perform histogram equalization on red channel:
subplot(3, 3, 4);
red = histoeq(red);
imshow(red, []); 
caption = sprintf('Histogram equalization of Red Image');
title(caption);
%compute and display the new histogram 
PlotHist(red, 7, 'Histogram of Red Image', 'r');

%perform histogram equalization on green channel:
subplot(3, 3, 5);
green = histoeq(green);
imshow(green, []); 
caption = sprintf('Histogram equalization of Green Image');
title(caption);
%compute and display the new histogram 
PlotHist(green, 8, 'Histogram of Red Image', 'g');


%perform histogram equalization on blue channel:
subplot(3, 3, 6);
blue = histoeq(blue);
imshow(blue, []); 
caption = sprintf('Histogram equalization of Blue Image');
title(caption);
%compute and display the new histogram 
PlotHist(blue, 9, 'Histogram of Blue Image', 'b');	

%reconstruct the image 
I(:,:,1)= red;
I(:,:,2)= green;
I(:,:,3)= blue;

subplot(3, 3, 3);
imshow(I, []);
caption = sprintf('Image After RGB Histogram Equalization');
title(caption);

%plots a bar chart of the histogram of a specific color channel.
function PlotHist(channel, plot, caption, color)

	[pixelCount, grayLevels] = imhist(channel, 256);
    subplot(3, 3, plot);
	bar(grayLevels, pixelCount, 'FaceColor', color, 'BarWidth', 1); 
	title(caption);
	grid on;
	%set the x axis range manually to be 0-255.
	xlim([0 255]); 
end
return;
end