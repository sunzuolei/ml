clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4D
rng(742);

targDigit   = 8;

%% Split data
numSamTrain = 4900; 
numSamTest  = 5000 - numSamTrain;
n           = size(X, 2);
iRand       = randperm(5000);
X           = X(iRand, :);
y           = y(iRand, :); 
xTrain      = X(1 : numSamTrain, :);
yTrain      = y(1 : numSamTrain, :);
yTrain      = (yTrain == targDigit);
xTest       = X( (numSamTrain + 1 ): end, :);
yTest       = y( (numSamTrain + 1 ): end, :);
yTest       = (yTest == targDigit);

%% Constrain the neural network
% structNN  = [400, 25, 10];
structNN  = [400, 25,25, 25,25,25, 1];
% structNN  = [400, 25, 25, 40, 10];
lambda    = 1.5;
numIter   = 100;

%% Perform neural network learning and predicting
[decTest,  proTest] = neuralNetwork(structNN, lambda, numIter,...
        xTrain, yTrain, xTest, yTest);

%% Visualize the classification result
numRow  = 5;
numCol  = fix( numSamTest / numRow );
dispDigits(numRow, numCol, xTest,...
            decTest, false, proTest, yTest);
        