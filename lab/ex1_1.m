I = imread('aerial.tiff');

%cover whole dynamic range [0 255]
I = imadjust(I);

%2D-DFT
cf1=fft(fft(I).').';
sz = ceil(size(cf1)/2);
cf = cf1([sz(1)+1:end, 1:sz(1)], [sz(2)+1:end, 1:sz(2)]);

%abs(cf) ==> πλατος του FFT
cfnormal=mat2gray(log(1+abs(cf)));
cfnormal1=mat2gray(abs(cf));

subplot(3,2,1), imshow(I), title('Original Image');
subplot(3,2,2), imshow(cfnormal1), title('Γραμμική απεικόνιση πλάτους DFT');
subplot(3,2,3), imshow(cfnormal), title('Λογαριθμική απεικόνιση πλάτους DFT');

%Low pass filtering
[x,y]=meshgrid(-128:127,-128:127);
z=sqrt(x.^2+y.^2);
c=(z<15);
cF=cf.*c;

%Inverse 2D-DFT 
IcF=(fft(fft(cF).').')';

subplot(3,2,4);imshow(mat2gray(log(1+abs(cf1)))), title('DFT της εικόνας');
subplot(3,2,5);imshow(mat2gray(log(1+abs(cF)))), title('Lowpass filtering');
subplot(3,2,6); imshow(mat2gray(abs(IcF))), title('Filtered Image');
