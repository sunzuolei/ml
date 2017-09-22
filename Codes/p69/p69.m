%=================================================================================
clear ; close all; clc
path(path, genpath('../p68'));

load('data2.mat');
[mu sigma2] = estimateGaussian(X);
p = multivariateGaussian(X, mu, sigma2);
pval = multivariateGaussian(Xval, mu, sigma2);
[epsilon F1] = selectThreshold(yval, pval);

fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('Best F1 on Cross Validation Set:  %f\n', F1);
fprintf('# Outliers found: %d\n', sum(p < epsilon));
fprintf('   (you should see a value epsilon of about 1.38e-18)\n\n');