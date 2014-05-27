clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap8

rng(666);

%% Refine data
ratioTrain  = 0.4;
ratioCrsVal = 0.4;

xAll    = [xTrain; xCrsVal; xTest];
yAll    = [yTrain; yCrsVal; yTest];

mAll    = length(yAll);
mTrain  = ceil(mAll * ratioTrain);
mCrsVal = floor(mAll * ratioCrsVal);

%% Learning curve
lambda    = 1;
numIter   = 200;
maxPwr    = 10;  
imgFold   = '../p49/Figs';
mkdir(imgFold);

numRep    = 50;
errCrsVal = zeros(mTrain, numRep);
errTrain  = zeros(mTrain, numRep);
errTest   = zeros(mTrain, numRep);

for power = 1 : maxPwr
    for rep = 1 : numRep
        %%
        iRand           = randperm(mAll);
        [xTrain, yTrain, xCrsVal, yCrsVal, xTest, yTest] = ...
        splitData(xAll(iRand, :), yAll(iRand, :), ratioTrain, ratioCrsVal);
        %% Argument polynomial features
        % Training data
        xTrainPoly      = mapPolyFeat(xTrain, power);
        [xTrainPoly, muTrain, sigmaTrain] = normFeat(xTrainPoly);
        xTrainPolyPlus  = [ones(size(xTrainPoly, 1), 1), xTrainPoly];
        % Cross Validation data
        xCrsValPoly     = mapPolyFeat(xCrsVal, power);
        xCrsValPoly     = normFeat(xCrsValPoly, muTrain, sigmaTrain);
        xCrsValPolyPlus = [ones(size(xCrsValPoly, 1), 1), xCrsValPoly];

        
        [errTrain(:, rep), errCrsVal(:, rep)] = learnCurveLinearReg...
       (xTrainPolyPlus, yTrain, xCrsValPolyPlus, yCrsVal, lambda, numIter);
    end
    %% Plot learning curve
    errTrainAvg  = mean(errTrain, 2);
    errCrsValAvg = mean(errCrsVal,2);
    figure('name',...
        sprintf('Learning curve for linear regression power=%d',power))
    plot(1 : mTrain, errTrainAvg, 'r-', 1 : mTrain, errCrsValAvg, 'g-', 'linewidth', 2);
    legend('Average train error', 'Average cross Validation', 'location', 'best');
    xlabel('Number of training examples')
    ylabel('Error')
    title(sprintf('\\lambda = %.1f, numIter = %d, power = %d',...
                    lambda, numIter, power));

    %% Save image
    imgName = sprintf('avgcurve_lam%.1f_nIter%d_pwr%d.png',...
                    lambda, numIter, power);
    print('-dpng', [imgFold, '/', imgName]);  
end 