clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap8

%% Refine data
ratioTrain  = 0.5;
ratioCrsVal = 0.25;

xAll    = [xTrain; xCrsVal; xTest];
yAll    = [yTrain; yCrsVal; yTest];

[xTrain, yTrain, xCrsVal, yCrsVal, xTest, yTest] = ...
         splitData(xAll, yAll, ratioTrain, ratioCrsVal);

%% Learning curve
lambda    = 0;
numIter   = 200;
maxPwr    = 10;  
imgFold   = '../p46/Figs';
mkdir(imgFold);

m         = length(yTrain);
for power = 1 : maxPwr
    %% Argument polynomial features
    % Training data
    xTrainPoly      = mapPolyFeat(xTrain, power);
    [xTrainPoly, muTrain, sigmaTrain] = normFeat(xTrainPoly);
    xTrainPolyPlus  = [ones(size(xTrainPoly, 1), 1), xTrainPoly];
    % Cross Validation data
    xCrsValPoly     = mapPolyFeat(xCrsVal, power);
    xCrsValPoly     = normFeat(xCrsValPoly, muTrain, sigmaTrain);
    xCrsValPolyPlus = [ones(size(xCrsValPoly, 1), 1), xCrsValPoly];
%     % Test data
%     xTestPoly       = mapPolyFeat(xTest, power);
%     xTestPoly       = normFeat(xTestPoly, muTrain, sigmaTrain);
%     xTestPolyPlus   = [ones(size(xTestPoly, 1), 1), xTestPoly];
    %% Plot learning curve
    [errTrain, errCrsVal] = learnCurveLinearReg(xTrainPolyPlus, yTrain,...
                        xCrsValPolyPlus, yCrsVal, lambda, numIter);

    figure('name',...
        sprintf('Learning curve for linear regression power=%d',power))
    plot(1 : m, errTrain, 'r-', 1 : m, errCrsVal, 'g-', 'linewidth', 2);
    legend('Train', 'Cross Validation', 'location', 'best');
    xlabel('Number of training examples')
    ylabel('Error')
    title(sprintf('\\lambda = %.1f, numIter = %d, power = %d',...
                    lambda, numIter, power));

    %% Save image
    imgName = sprintf('curve_lam%.1f_nIter%d_pwr%d.png',...
                    lambda, numIter, power);
    print('-dpng', [imgFold, '/', imgName]);    
    
end 