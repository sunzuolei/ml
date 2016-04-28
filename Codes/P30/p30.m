clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap4D
rng(531);

%%
numSamTrain = 4900; 
numSamTest  = 5000 - numSamTrain;
n           = size(X, 2);
iRand       = randperm(5000);
X           = X(iRand, :);
y           = y(iRand, :); 
xTrain      = [ones(numSamTrain, 1), X(1 : numSamTrain, :)];
yTrain      = y(1 : numSamTrain, :);

xTest       = [ones(numSamTest, 1), X( (numSamTrain + 1 ): end, :)];
yTest       = y( (numSamTrain + 1 ): end, :);

%%
initTheta   = zeros(n + 1, 1);
options = optimoptions(@fminunc, 'GradObj', 'on','MaxIter', 500);
% options = optimset('MaxIter', 500);

%%
optThetaAll = zeros(n + 1, 10);  
tic;
for i = 1 : 10
    optThetaAll(:, i) = ...
        fmincg(@(t)(computeCostLog( xTrain, yTrain == i , t)),...
                    initTheta, options);
end
toc;


%%
[proTest, decTest] = max( sigmoid(xTest * optThetaAll), [], 2);

%% Compute accuracy calculation
[~, decTrain] = max( sigmoid(xTrain * optThetaAll), [], 2);
fprintf('Train Accuracy (based on training data): %.2f%%\n', ...
        mean(double(decTrain == yTrain)) * 100);
%
fprintf('Train Accuracy (based on test data): %.2f%%\n', ...
        mean(double(decTest  == yTest)) * 100);

%% Visualize the classification result
numRow  = 5;
numCol  = fix( numSamTest / numRow );
dispDigits(numRow, numCol, xTest(:, 2 : end),...
            decTest, false, proTest, yTest);
