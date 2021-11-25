I = imread('factory.jpg');
I = rgb2gray(I);

%edge detection with sobel method
h1 = [-1 -2 -1; 0 0 0; 1 2 1];
BW1 = imfilter(I,h1);

%edge detection with prewitt method
h2 = [-1 -1 -1; 0 0 0; 1 1 1];
BW2 = imfilter(I,h2);

figure,subplot(1,2,1),imshow(BW1);title('Sobel mask');

       subplot(1,2,2),imshow(BW2);title('Prewitt mask');
       

          
   