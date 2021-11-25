%read the image 
I = imread('clock.tiff');
[rows, columns] = size(I);
noise =(rand(size(I))); 
d = 0.2; 
output=I; 

for i=1:rows
    for j=1:columns
        if(noise(i,j)>(1-d/2))
            output(i,j)=1;
        end
        if(noise(i,j)<d/2)
            output(i,j)=0;
        end
    end
end

I=output;
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