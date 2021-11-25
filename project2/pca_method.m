% Script for Principal Components Analysis
% author: Evangelia Konstantopoulou
% =======================================================================

top = 10; % number of eigenvalues to consider
trainImages = 100; % number of training images 
testImages = 11; % number of test images

% loading the training images to compute TrainSet which will be a 100 x 10000 matrix 
cd Database;
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
  

% subtract the mean of images in TrainSet
% calculate mean
train_mean = sum(TrainSet,1)/(trainImages);

for i = 1:trainImages
    TrainSet(i,:) = TrainSet(i,:) - train_mean;
end

% find covariance matrix 
covmat = (TrainSet*TrainSet')/trainImages;
% calculate eigenvectors 
[V, D] = eig(covmat);
% transEigen contains the final eigenvectors transformed into the original space
transEigen = TrainSet'*V;

% only keep top eigenvalues and store them in N
for i = 0:top-1
    N(:,i+1) = transEigen(:,trainImages-i);
    % normalize eigenvectors to form orthogonal space
    U = N(:,i+1);
    norm = (U'*U)^0.5;
    N(:,i+1) = N(:,i+1) / norm; 
end

for i = 1:trainImages
    TrainVect(:,i) = (N)'*(TrainSet(i,:))'; % training set of reduced dimensional space 
end

% loading the test images to compute TestSet which will be a 11 x 10000 matrix 
cd ..\test;
imFile = dir('*.jpg');
n=length(imFile);

    for j = 1:n
        
        filename = imFile(j).name;
        I = im2double(imread(filename));  
        
        [X, Y, Z] = size(I);
        
        %turn image into grayscale if not
        if(Z == 3)
            I = rgb2gray(I);
        end
        
        vals = reshape(I, 1, X*Y);
        TestSet(j, :) = vals;
        
    end

% subtract the mean of images in TestSet
% calculate mean
test_mean = sum(TestSet,1)/testImages;

for i = 1:testImages
    TestSet(i,:) = TestSet(i,:) - test_mean;
end

for i = 1:testImages
    TestVect(:,i) = (N)'*(TestSet(i,:))'; % testing set of reduced dimensional space
end

for i = 1:testImages
    T1 = TestVect(:,i);
    
    for j = 1:trainImages
        T2 = TrainVect(:,j);
        % calculate distance between T1 and T2
        dist(j)= (T1-T2)'*(T1-T2); 
    end
    % find index of sample with the shortest distance
    [~ , index] = min(dist);
    Tracker(i) = index;
    
end

% calculate classification accuracy
accuracy = 0;
count = 1;

    for count = 1 : 11
        if ((Tracker(count) >= count) && (Tracker(count) <= 11))
            accuracy = accuracy + 1;
        end
    end

accuracy