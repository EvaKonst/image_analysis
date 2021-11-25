%load image
I = load('flower.mat');
I = cell2mat(struct2cell(I));
I = im2double(I);

j = 1;
%variance threshold
tt = [0.05:0.01:0.5];
%Sort in descending order from most to least influential
tt = sort(tt,'descend');

for i=tt 
     %call function thresh_method 
    [I2]=thresh_method(I,i);
    thresh_mse(j) = sum(sum((I-I2)*(I-I2)))/(size(I,1)*size(I,2));
    j = j + 1;
end

plot(thresh_mse);
legend('Thresholding Method');
xlabel('r in [5%,50%]');
ylabel('MSE');
grid on
xticklabels({0.05:0.5})