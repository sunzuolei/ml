clear all; clc; close all;

path(path, genpath('../../Codes'));

load dataChap10A
plotData(X, y);
% print('-dpng', 'rawdata.png');
C = 100;
model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
visualizeBoundaryLinear(X, y, model);
title(sprintf('C = %.1f', C));
print('-dpng', sprintf('svm_c=%.1f.png', C));