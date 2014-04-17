clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap4D
load dataChap6
rng(666);

%%
numSamTest  = 100; 
n           = size(X, 2);
iRand       = randperm(5000);
X           = X(iRand, :);
y           = y(iRand, :); 

xTest       = X( end - numSamTest + 1: end, :);
yTest       = y( end - numSamTest + 1: end, :);

%% Predict with neural network
[decTest, proTest] = pred3layerNN(xTest, Theta1, Theta2);
[decAll,  proAll ] = pred3layerNN(X,     Theta1, Theta2);

%% Compute accuracy calculation
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
