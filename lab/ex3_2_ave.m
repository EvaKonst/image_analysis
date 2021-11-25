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

%Display it
subplot(1, 2, 1);
imshow(I, []);
axis on;
title('Noisy Image Before Implementation of Moving Average Filter');
drawnow;

%user must input an odd window width
default = 5;
titleBar = 'Enter an odd window width';
instructions = 'Enter an odd window width';
input = inputdlg(instructions, titleBar, 1, {num2str(default)});

if isempty(input),return,end; 

%if an even number is inserted instead of an odd there will be a half pixel
%shift in the resulting image
WinSz = str2double(cell2mat(input));

%the half-window will calculate the average of everything inside it
hWinSz = floor(WinSz / 2);
kernel = ones(WinSz) / WinSz ^ 2;

result = zeros(size(I)); 

%we scan the window over the image pixel by pixel, going by rows first then columns 
for col = hWinSz + 1 : columns - hWinSz
	for row = hWinSz + 1 : rows - hWinSz
        
		sum = 0; 
		for c = 1 : WinSz
            %assign the pixel of the original image with the pixel of the
            %filter window to then multiply them
			cc = col + c - hWinSz - 1;
			for r = 1 : WinSz
				rr = row + r - hWinSz - 1;
				%calculate the product for this window location and then
				%sum it up
				sum = sum + double(I(rr, cc)) * kernel(r, c);
			end
		end
		%assign the filtered value to the corresponding place in the result
		result(row, col) = sum;
	end
end

%display result
subplot(1, 2, 2);
imshow(result, []);
caption = sprintf('Image After Implementation of Moving Average Filter of Window: %d', WinSz);
title(caption);
axis on;
