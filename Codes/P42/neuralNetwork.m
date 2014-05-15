function [decTest,  proTest] = neuralNetwork(structNN, lambda, numIter, ...
        xTrain, yTrain, xTest, yTest, xCV, yCV)

numLayer  = length(structNN);

%% Initialize weights
nodNextLayer  = structNN(2 : end);
nodPrevLayer  = structNN(1 : end-1) + 1;
numNode       = nodNextLayer .* nodPrevLayer;
numNodeAll    = sum( numNode );
thetaVecInit  = zeros(numNodeAll, 1);
%
iStart        = 1;
iEnd          = numNode(1);
for i = 1 : numLayer - 1
    theta     = initWeightNN(structNN(i),  structNN(i + 1));
    thetaVecInit(iStart : iEnd) = theta(:);
    if i < numLayer - 1
        iStart    = iEnd + 1;
        iEnd      = iStart + numNode(i + 1) - 1;
    end
end

%% Train the neural network
% options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 500);
options = optimset('MaxIter', numIter);
thetaVecOpt = fmincg(...
   @(t)costNN(t, structNN, xTrain, yTrain, lambda),...
   thetaVecInit, options);

%% Roll the thetaVec again
thetaCellOpt  = rollTheta(thetaVecOpt, structNN);

%% Infer the new data
[decTest,  proTest] = forwPropNN(xTest, thetaCellOpt, structNN);
[decTrain, ~      ] = forwPropNN(xTrain,thetaCellOpt, structNN);

%% Compute accuracy
fprintf('Classification Accuracy (based on training data): %.2f%%\n', ...
        mean(double(decTrain == yTrain)) * 100);
%
fprintf('Classification Accuracy (based on test data): %.2f%%\n', ...
        mean(double(decTest == yTest)) * 100);
    
%% 
if nargin == 9
   [decCV, ~ ] = forwPropNN(xCV, thetaCellOpt, structNN); 
   fprintf('Classification Accuracy (based on cross validation data): %.2f%%\n', ...
        mean(double(decCV == yCV)) * 100);
end