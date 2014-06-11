clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4C.mat

%% Split data
degree = 6;
xTrain = genFeats(data(:, 1), data(:, 2), degree);
yTrain = data(:, 3);
xTest  = [0.1, 0.1; -0.5, -0.4; 0.3, 0.35; 0.25, -0.5; 1, -0.3];
xTest  = genFeats(xTest(:, 1), xTest(:, 2), degree);
yTest  = [1; 0; 1; 1; 0];

%% Constrain the neural network
structNN  = [size(xTrain, 2),  1];
lambda    = 1.5;
numIter   = 500;

%% Perform neural network learning and predicting
[decTest,  proTest] = neuralNetwork(structNN, lambda, numIter,...
        xTrain, yTrain, xTest, yTest);


        