clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap4D
rng(555);

%% Split data
numSamTrain = 4900; 
numSamTest  = 5000 - numSamTrain;
n           = size(X, 2);
iRand       = randperm(5000);
X           = X(iRand, :);
y           = y(iRand, :); 
xTrain      = [ones(numSamTrain, 1), X(1 : numSamTrain, :)];
yTrain      = y(1 : numSamTrain, :);
targDigit   = 8;
yTargTrain  = (yTrain == targDigit);

xTest       = X( (numSamTrain + 1 ): end, :);
yTest       = y( (numSamTrain + 1 ): end, :);
yTargTest   = (yTest == targDigit);

%%
initTheta   = zeros(n + 1, 1);
options     = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 500);
%%
tic;
% optTheta = ...
% 	fminunc(@(t)(computeCostLog( xTrain, yTargTrain, t)),...
%                 initTheta, options);
optTheta = ...
	fmincg(@(t)(computeCostLog( xTrain, yTargTrain, t)),...
                initTheta, options);
toc;


%%
decTest     = predictLogReg(optTheta, xTest);

%% Compute accuracy calculation
decTrain    = predictLogReg(optTheta, xTrain(:, 2:end));
fprintf('Train Accuracy (based on training data): %.2f%%\n', ...
        mean(double(decTrain == yTargTrain)) * 100);
    
fprintf('Train Accuracy (based on test data): %.2f%%\n', ...
        mean(double(decTest  == yTargTest)) * 100);

%% Visualize the classification result
numRow     = 5;
numCol     = fix( numSamTest / numRow );
dispDigits(numRow, numCol, xTest, decTest);
