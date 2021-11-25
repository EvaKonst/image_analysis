%Total thresholding: thresholds were computated using the otsu method

BW1 = im2uint8(BW1);
%calculate a 16-bin histogram for the image
[counts,x] = imhist(BW1,16);
stem(x,counts)
%compute a global threshold using the histogram counts
T = otsu_thresh(counts);
%create a binary image using the computed threshold and display the image
Bin = imbinarize(BW1,T);

BW2 = im2uint8(BW2);
%calculate a 16-bin histogram for the image
[counts2,x2] = imhist(BW2,16);
stem(x2,counts2);
%compute a global threshold using the histogram counts
T2 = otsu_thresh(counts2);
%create a binary image using the computed threshold and display the image
Bin2 = imbinarize(BW2,T2);

figure,subplot(1,2,1),imshow(Bin);title('Sobel after total thresholding');
       subplot(1,2,2),imshow(Bin2);title('Prewitt after total thresholding');