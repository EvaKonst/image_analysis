% Script for Autoencoder Training
% author: Evangelia Konstantopoulou
% =======================================================================

% loading the training images to compute TrainSet which will be a 100 x 10000 matrix 
cd Database;;
imFile = dir('*.jpg');
n = length(imFile);

    for j = 1:n
        
        filename = imFile(j).name;
        I = im2double(imread(filename));
        
        [X, Y, Z] = size(I);
        
        %turn image into grayscale if not
        if(Z == 3)
            I = rgb2gray(I);
        end
        
        vals = reshape(I, 1, X*Y);
        TrainSet(j, :) = vals;
        
    end

%train the Autoencoder
rng('default')    
hiddenSize = 50;
autoenc = trainAutoencoder(TrainSet,hiddenSize, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.15, ...
    'ScaleData', false);

view(autoenc)  

% loading the test images to compute TestSet which will be a 11 x 10000 matrix 
cd ..\test;
f=dir('*.jpg');
files={f.name}

for k=1:numel(files)
    
  I=imread(files{k});
  I=im2double(I);
  TestSet{k} = rgb2gray(I);
  
end

TestSet=cell2mat(TestSet);
reconstructed = predict(autoenc,TestSet);

%find performance
mseError = mse(TestSet-reconstructed);