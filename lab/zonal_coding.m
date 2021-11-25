function [I2] = zonal_coding(I,r)
%slice in non-overlapping areas of dimensions 32 × 32
sub = 32;
cf = zeros(sub,sub,256);
variance = zeros(256,1);
I2 = zeros(size(I));
k = 1;
l = 1;

%create regions of size 32 x 32 and apply 2D-DCT on the blocks and collect
%the coefficients
for i = 1:sub:size(I,1)
    for j = 1:sub:size(I,2)
        region = I(i:i+sub-1,j:j+sub-1);
        coef = dct2(region);
        cf(:,:,k) = coef;
        k = k + 1;
    end
end

%Compute the variance of each of the transform coefficients   
k=1;
for i =1:sub
   for j =1:sub
      variance(k)=var(cf(i,j,:));
      k=k+1;
   end
end

variance=reshape(variance,[sub sub]);
variance=variance';

%Keep only the top r% of the coefficients and discard rest
top=(variance>r);

%Perform 2D-IDCT on the blocks to get resulting image
for i =1:sub:size(I,1)
    for j =1:sub:size(I,2)
            I2(i:i+sub-1,j:j+sub-1)=idct2(cf(:,:,l).*top);
            l=l+1;
    end
end
end