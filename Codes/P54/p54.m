clear all; clc; close all;

path(path, genpath('../../Codes'));

load dataChap10C
plotData(X, y);
% print('-dpng', 'rawdata.png');
mkdir('../P54/Test Figs');
% Try different SVM Parameters here
[C, sigma] = testParam(X, y, Xval, yval);
fprintf('Best parameter found:\nC=%.2f, sigma=%.2f\n', C, sigma);

% Train the SVM
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
visualizeBoundary(X, y, model);
title(sprintf('C = %.2f, \\sigma=%.2f', C, sigma));
print('-dpng', sprintf('c=%.2f_sigma=%.2f.png', C, sigma));