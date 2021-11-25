function [I2] = thresh_method(I,r)

%slice in non-overlapping areas of dimensions 32 × 32
sub = 32;
cf = zeros(sub,sub,256);
variance = zeros(256,1);
I2 = zeros(size(I));
k = 1;
l = 1;
cf =zeros(sub,sub,256);
top = zeros(sub,sub,256);

%create regions of size 32 x 32 and apply 2D-DCT on the blocks and collect
%the coefficients with the biggest magnitude
for i = 1 : sub : size(I,1)
    for j = 1 : sub :size(I,2)
        region = I(i:i+sub-1,j:j+sub-1);
        coef = dct2(region);
        magn = abs(coef);
        %Keep only the top r% of the coefficients by storing them in a 3D array and discard rest
        top(:,:,k) = (magn>r);
        cf(:,:,k) = coef;
        k = k + 1;
    end
end

%Perform 2D-IDCT on the blocks to get resulting image
for i = 1:sub:size(I,1)
    for j = 1:sub:size(I,2)
            I2(i:i+sub-1,j:j+sub-1) = idct2(cf(:,:,l).*top(:,:,l));
            l = l + 1;
    end
end
end