clear all; clc; close all;

path(path, genpath('../../Codes'));

load dataChap10B
plotData(X, y);
% print('-dpng', 'rawdata.png');
% SVM Parameters
C = 10; sigma = 0.1;

% We set the tolerance and max_passes lower here so that the code will run
% faster. However, in practice, you will want to run the training to
% convergence.
% http://en.wikipedia.org/wiki/RBF_kernel
model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
visualizeBoundary(X, y, model);

title(sprintf('C = %.1f, \\sigma=%.2f', C, sigma));
print('-dpng', sprintf('svm_c=%.1f_sigma=%.2f.png', C, sigma));