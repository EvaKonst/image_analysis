%load image
I = load('flower.mat');
I = cell2mat(struct2cell(I));
I = im2double(I);

k = 1;
%r values
tr = [0.05:0.001:0.5];
%Sort in descending order from most to least influential
tr = sort(tr,'descend');

for i=tr 
    %call function zonal_coding 
    [I2]=zonal_coding(I,i);
    zonal_mse(k) = sum(sum((I-I2)*(I-I2)))/(size(I,1)*size(I,2));
    k = k + 1;
end

%calculate mse for r in [5% 50%]
figure; plot(zonal_mse);
legend('Zone Method');
xlabel('r in [5%,50%]');
ylabel('MSE');
grid on
xticklabels({0.05:0.5})