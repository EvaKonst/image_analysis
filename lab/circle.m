I = load('circle.mat');
I = cell2mat(struct2cell(I));

%perform adaptive histogram equalization to clean up image
LE = adapthisteq(I,'NumTiles',[8 8],'clipLimit',1,'Distribution','rayleigh');

figure,subplot(1,2,1),imshow(I);title('Before Adaptive Histogram Equalization');

      subplot(1,2,2),imshow(LE);title('After Adaptive Histogram Equalization');