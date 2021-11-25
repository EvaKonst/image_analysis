%read the image 
I = imread('clock.tiff');
I = im2double(I);
%get the dimensions of the image
[rows, columns] = size(I);

varI = std2(I)^2;
sigma_noise = sqrt(varI/10^(15/10));
N = sigma_noise*randn(size(I));
I = I+N;
subplot(1, 2, 1);
imshow(I, []);
axis on;
title('Noisy Image Before Implementation of Median Filter');
drawnow;

result=zeros(rows,columns);

%traverse the image pixel by pixel starting from columns and then rows
for i=2:rows-1
    for j=2:columns-1
        %find the median of the neighbouring pixels
        neighbours=[I(i-1,j-1),I(i-1,j),I(i-1,j+1),I(i,j-1),I(i,j),I(i,j+1),I(i+1,j-1),I(i+1,j),I(i+1,j+1)];
        result(i,j)=median(neighbours);
    end
end

%display result
subplot(1, 2, 2);
imshow(result, []);
caption = sprintf('Image After Implementation of Median Filter');
title(caption);
axis on;