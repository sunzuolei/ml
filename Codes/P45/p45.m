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

%%
figure('name', 'Visualize dam data')
hold on;
plot(xTrain,  yTrain,  'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
plot(xCrsVal, yCrsVal, 'go', 'MarkerSize', 7,  'LineWidth', 1.5);
plot(xTest,   yTest,   'ms', 'MarkerSize', 7,  'LineWidth', 1.5);
legend('Data for training', 'Data for cross validation', ...
       'Data for test',     'location', 'best');
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');
box on

%% Model selection of the polynomial regression
lambda    = 1;
numIter   = 200;
maxPwr    = 10;  
imgFold   = '../p45/Figs';
mkdir(imgFold);
errCrsVal = zeros(maxPwr, 1);
errTrain  = zeros(maxPwr, 1);
errTest   = zeros(maxPwr, 1);
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
    % Test data
    xTestPoly       = mapPolyFeat(xTest, power);
    xTestPoly       = normFeat(xTestPoly, muTrain, sigmaTrain);
    xTestPolyPlus   = [ones(size(xTestPoly, 1), 1), xTestPoly];
    %% Train theta
    optTheta        = trainThetaLinearReg(xTrainPolyPlus, ...
                                            yTrain, lambda, numIter);
    %% Compute error
    errTrain(power) = computeCostReg(xTrainPolyPlus,  yTrain,  optTheta, 0);
    errCrsVal(power)= computeCostReg(xCrsValPolyPlus, yCrsVal, optTheta, 0);
    errTest(power)  = computeCostReg(xTestPolyPlus,   yTest,   optTheta, 0);
    %% Plot model fitting
    figure('name', sprintf('Polynomial regression power=%d', power))
    title(sprintf('\\lambda = %.1f, numIter = %d, power = %d',...
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
       'Data for test', sprintf('Regression (p=%d)', power),...
       'location', 'best');
    %% Save image
    imgName = sprintf('lam%.1f_nIter%d_pwr%d.png',...
                    lambda, numIter, power);
    print('-dpng', [imgFold, '/', imgName]);
end 
%%
figure('name', 'Model selection')
hold on;
plot(1 : maxPwr, errTrain,  'r-*',...
     1 : maxPwr, errCrsVal, 'g-o',...
     1 : maxPwr, errTest,   'b-x',  'linewidth', 1);
legend('Train error', 'Cross Validation error', 'Test error',...
     'location', 'best');
xlabel(sprintf('Power'));
ylabel('Error')
title(sprintf('\\lambda = %.1f, numIter = %d', lambda, numIter));
set(gca, 'XTick',      1:maxPwr);
% set(gca, 'XTickLabel', tickLab);

%% Find the minimum error
[minErrCrs, idxCrs] = min(errCrsVal);
[minErrTst, idxTst] = min(errTest);
pwrVec = 1 : maxPwr;
plot(pwrVec(idxCrs), minErrCrs, 'mp', 'MarkerSize', 10, 'LineWidth', 1.5);
plot(pwrVec(idxTst), minErrTst, 'ks', 'MarkerSize', 10, 'LineWidth', 1.5);
imgName = sprintf('errors_lam%.1f_numIter%d.png', lambda, numIter);
print('-dpng', [imgFold, '/', imgName]);