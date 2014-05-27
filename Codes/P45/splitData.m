function [xTrain, yTrain, xCrsVal, yCrsVal, xTest, yTest] = ...
         splitData(xAll, yAll, ratioTrain, ratioCrsVal)

m       = length(yAll);
mTrain  = ceil(m * ratioTrain);
mCrsVal = floor(m * ratioCrsVal);

xTrain  = xAll(1 : mTrain, :);
yTrain  = yAll(1 : mTrain, :);

xCrsVal = xAll(mTrain + 1: mTrain + mCrsVal, :);
yCrsVal = yAll(mTrain + 1: mTrain + mCrsVal, :);

xTest   = xAll(mTrain + mCrsVal + 1: end,:);
yTest   = yAll(mTrain + mCrsVal + 1: end,:);