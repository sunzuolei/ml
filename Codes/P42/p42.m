clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4D
rng(666);

%% Split data
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
structNN  = [400, 25, 10];
% structNN  = [400, 10];
% structNN  = [400, 25, 25, 40, 10];
lambda    = 1.5;
numIter   = 500;

%% Perform neural network learning and predicting
[decTest,  proTest] = neuralNetwork(structNN, lambda, numIter,...
        xTrain, yTrain, xTest, yTest);

%% Visualize the classification result
numRow  = 5;
numCol  = fix( numSamTest / numRow );
dispDigits(numRow, numCol, xTest,...
            decTest, false, proTest, yTest);
        