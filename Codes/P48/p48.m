clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap8

%% Refine data
% ratioTrain  = 0.5;
% ratioCrsVal = 0.25;
% 
% xAll    = [xTrain; xCrsVal; xTest];
% yAll    = [yTrain; yCrsVal; yTest];
% 
% [xTrain, yTrain, xCrsVal, yCrsVal, xTest, yTest] = ...
%          splitData(xAll, yAll, ratioTrain, ratioCrsVal);

%% Selecting regularization factor
numIter   = 200;
maxPwr    = 10;  
imgFold   = '../p48/Figs';
mkdir(imgFold);
lambdaVec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 1.5 2 2.5 3 3.5 4 5 6 9 10];
%% The fitting for the spectified lambda
power = 5;
for lambda = lambdaVec
    %% Cook data
    xTrainPoly      = mapPolyFeat(xTrain, power);
    [xTrainPoly, muTrain, sigmaTrain] = normFeat(xTrainPoly);
    xTrainPolyPlus  = [ones(size(xTrainPoly, 1), 1), xTrainPoly];
    
    %% Train theta
    optTheta        = trainThetaLinearReg(xTrainPolyPlus, ...
                                            yTrain, lambda, numIter);
    %%
    figure('name', sprintf('Polynomial regression power=%d \\lambda=%.3f',...
            power, lambda))
    title(sprintf('\\lambda = %.3f, numIter = %d, power = %d',...
                    lambda, numIter, power));
    hold on;
    plot(xTrain,  yTrain,  'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
    plot(xCrsVal, yCrsVal, 'go', 'MarkerSize', 7,  'LineWidth', 1.5);
    plot(xTest,   yTest,   'ms', 'MarkerSize', 7,  'LineWidth', 1.5);
    %
    xVis     = min(xTrain) - 10 : 0.01 : max(xTrain) + 20 ;
    xVisPoly = mapPolyFeat(xVis', power);
    xVisPoly = normFeat(xVisPoly, muTrain, sigmaTrain);
    xVisPolyPlus = [ones(length(xVis), 1), xVisPoly];
    plot(xVis, xVisPolyPlus * optTheta, '-', 'LineWidth', 2)
    xlabel('Change in water level (x)');
    ylabel('Water flowing out of the dam (y)');
    legend('Data for training', 'Data for cross validation', ...
       'Data for test', sprintf('Regression (\\lambda=%d)', lambda),...
       'location', 'best');
    %% Save image
    imgName = sprintf('lam%.3f_nIter%d_pwr%d.png',...
                    lambda, numIter, power);
    print('-dpng', [imgFold, '/', imgName]);
end