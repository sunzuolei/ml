function [errTrain, errCrsVal] = learnCurveLinearReg(x, y, xCV, yCV,...
                                   lambda, numIter)

m = size(y, 1);

%%
if size(x, 1) ~= m
   error('Size of x and y does not match.'); 
end

if size(xCV, 1) ~= size(yCV, 1)
   error('Size of xCV and yCV does not match'); 
end

if nargin < 6
    numIter = 200;
end

%%
errTrain  = zeros(m, 1);
errCrsVal = zeros(m, 1);

%%
for i = 1 : m
    xTrain      = x(1 : i, :);
    yTrain      = y(1 : i, :);
    %% Train theta
    optTheta     = trainThetaLinearReg(xTrain, yTrain, lambda, numIter);
    %% Compute error
    errTrain(i)  = computeCostReg(xTrain, yTrain, optTheta, 0);
    errCrsVal(i) = computeCostReg(xCV,    yCV,   optTheta, 0);
end

