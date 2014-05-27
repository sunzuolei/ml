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


%% Selecting regularization factor
numIter   = 200;
maxPwr    = 10;  
imgFold   = '../p50/Figs';
mkdir(imgFold);

lambdaVec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 1.5 2 2.5 3 3.5 4 5 6 9 10]';
numLam    = length(lambdaVec);
%
numRep    = 20;
errCrsVal = zeros(numLam, numRep);
errTrain  = zeros(numLam, numRep);
errTest   = zeros(numLam, numRep);

for power = 1 : maxPwr
    %% Argument polynomial features    
    for rep = 1 : numRep
        %%
        iRand           = randperm(mAll);        
        [xTrain, yTrain, xCrsVal, yCrsVal, xTest, yTest] = ...
        splitData(xAll(iRand, :), yAll(iRand, :), ratioTrain, ratioCrsVal);
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
        for i = 1 : numLam
            %%
            optTheta     = trainThetaLinearReg(xTrainPoly, yTrain,...
                            lambdaVec(i), numIter);
            %% Compute error
            errTrain(i, rep)  = computeCostReg(xTrainPoly, yTrain, optTheta, 0);
            errCrsVal(i, rep) = computeCostReg(xCrsValPoly, yCrsVal, optTheta, 0);
            errTest(i, rep)   = computeCostReg(xTestPoly, yTest, optTheta, 0);
        end
    end
    %%
    errTrainAvg = mean(errTrain, 2);
    errCrsValAvg   = mean(errCrsVal, 2);
    errTestAvg  = mean(errTest, 2);
    figure('name',...
        sprintf('Tuning regularization factor, power=%d',power))
    hold on;
    plot(lambdaVec, errTrainAvg,   'r-x', ...
         lambdaVec, errCrsValAvg,  'g-*', ...
         lambdaVec, errTestAvg,    'b-o', 'linewidth', 1);
    legend('Avg train error', 'Avg cross validation error',...
        'Avg test error', 'location', 'best');
    xlabel(sprintf('\\lambda'));
    ylabel('Avg error')
    title(sprintf('numIter = %d, power = %d', numIter, power));
    % Specify the x label
    str     = strsplit(mat2str(lambdaVec), ';');
    str     = strrep(str, '[', '');
    str     = strrep(str, ']', '');
    tickLab = cellstr(str);
    set(gca, 'XTick',      lambdaVec);
    set(gca, 'XTickLabel', tickLab);
    %% Find the minimum error
    [minErrCrs, idxCrs] = min(errCrsValAvg);
    [minErrTst, idxTst] = min(errTestAvg);
    plot(lambdaVec(idxCrs), minErrCrs, 'mp',...
        'MarkerSize', 10, 'LineWidth', 1.5);
    plot(lambdaVec(idxTst), minErrTst, 'ks',...
        'MarkerSize', 10, 'LineWidth', 1.5);
    
    %% Save image
    imgName = sprintf('nIter%d_pwr%d.png',...
                    numIter, power);
    print('-dpng', [imgFold, '/', imgName]);  
end 

