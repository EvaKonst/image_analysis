% Script for Principal Components Analysis
% author: Evangelia Konstantopoulou
% =======================================================================

top = 50; % number of eigenvalues to consider
nTrain = 100; % number of training images 
nTest = 11; % number of test images

% loading the training images to compute TrainSet which will be a 101 x 10000 matrix 
cd('C:\Users\konst\Documents\ImageAnalysis\partB\DataBase');
im_file = dir('*.jpg');
n = length(im_file);

    for i = 1:n
        
        filename = im_file(i).name;
        I = im2double(imread(filename));
        
        [X, Y, Z] = size(I);
        
        %turn image into grayscale
        if(Z == 3)
            I = rgb2gray(I);
        end
        
        val = reshape(I, 1, X*Y);
        TrainSet(i, :) = val;
        
    end

% subtract the mean of images in TrainSet
% calculate mean
train_mean = sum(TrainSet,1)/(nTrain);

for i = 1:nTrain
    TrainSet(i,:) = TrainSet(i,:) - train_mean;
end

% calculate covariance matrix 
covmat = (TrainSet*TrainSet')/nTrain;
% find eigenvectors 
[V, D] = eig(covmat);
% transEigen contains the final eigenvectors transformed into the original space
transEigen = TrainSet'*V; 

% only keep top eigenvalues and store them in N
for i = 0:top-1
    N(:,i+1) = transEigen(:,nTrain-i);
    U = N(:,i+1);
    % normalize eigenvectors to form orthogonal space
    norm = (U'*U)^0.5;
    N(:,i+1) = N(:,i+1)/norm; 
end

% loading the test images to compute TestSet which will be a 11 x 10000 matrix 
cd('C:\Users\konst\Documents\ImageAnalysis\partB\test');
im_file = dir('*.jpg');
n=length(im_file);

    for i = 1:n
        filename = im_file(i).name;
        I = im2double(imread(filename));   
        
        [X, Y, Z] = size(I);
        
        if(Z == 3)
            I = rgb2gray(I);
        end
        
        val = reshape(I, 1, X*Y);
        TestSet(i, :) = val;
        
    end

% subtract the mean of images in TestSet
% calculate mean
test_mean = sum(TestSet,1)/nTest;

for i = 1:nTest
    TestSet(i,:) = TestSet(i,:) - test_mean;
end

%compare test image with nTrain images in reduced dimensional space of top
%eigenvectors
for i = 1:nTrain
    TrainVect(:,i) = (N)'*(TrainSet(i,:))'; % training set of reduced dimensional space 
end

for i = 1:nTest
    TestVect(:,i) = (N)'*(TestSet(i,:))'; % testing set of reduced
end

for i = 1:nTest
    Z1 = TestVect(:,i);
    for i = 1:nTrain
        Z2 = TrainVect(:,i);
        Dist(i)= (Z1-Z2)'*(Z1-Z2); % Distance between Z1 and Z2
    end
    % Finding index of the least distant sample
    [value, index] = min(Dist);
    Tracker(i) = index;

end

%Checking Classification accuracy
accuracy = 0;
cnt = 1;
%for i = 1:nFolder
    for i = cnt: cnt + 10
        if ((Tracker(cnt) >= cnt) && (Tracker(cnt) <= cnt + 10))
            accuracy = accuracy + 1;
        end
    end
    
    accuracy
    
           % cnt = cnt + nTest;
%end
        
%accuracy = (accuracy)/2