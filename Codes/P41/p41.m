clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4D
rng(666);

%% Slipt data
numSamTrain = 4900; 
numSamTest  = 5000 - numSamTrain;
n           = size(X, 2);
iRand       = randperm(5000);
X           = X(iRand, :);
y           = y(iRand, :); 
xTrain      = X(1 : numSamTrain, :);
yTrain      = y(1 : numSamTrain, :);
xTest       = X( (numSamTrain + 1 ): end, :);
yTest       = y( (numSamTrain + 1 ): end, :);

%% Constrain the neural network
sizeIn    = 400;
sizeHid   = 25;
sizeOut   = 10;
lambda    = 1;

%% 
thetaInit1 = initWeightNN(sizeIn,  sizeHid);
thetaInit2 = initWeightNN(sizeHid, sizeOut);
thetaVecInit = [thetaInit1(:); thetaInit2(:)];

%% Train the neural network
% options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 500);
options = optimset('MaxIter', 500);
thetaVecOpt = fmincg(...
   @(t)cost3LayerNN(t, sizeIn, sizeHid, sizeOut, xTrain, yTrain, lambda),...
   thetaVecInit, options);

%% Roll the thetaVec again
Theta1     = reshape(thetaVecOpt(1 : sizeHid * (sizeIn+1) ),...
                     sizeHid, sizeIn+1);
Theta2     = reshape(thetaVecOpt(sizeHid * (sizeIn+1) + 1 : end ),...
                     sizeOut, sizeHid + 1);

%% Infer the new data
[decTest, proTest] = forwProp3Layer(xTest, Theta1, Theta2);
[decAll,  proAll ] = forwProp3Layer(X,     Theta1, Theta2);

%% Compute accuracy
fprintf('Classification Accuracy (based on all data): %.2f%%\n', ...
        mean(double(decAll == y)) * 100);
%
fprintf('Classification Accuracy (based on Test data): %.2f%%\n', ...
        mean(double(decTest == yTest)) * 100);

%% Visualize the classification result
numRow  = 5;
numCol  = fix( numSamTest / numRow );
dispDigits(numRow, numCol, xTest,...
            decTest, false, proTest, yTest);
        