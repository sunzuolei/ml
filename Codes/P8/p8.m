clear all; clc; close all;
load '../Data/dataChap3.mat';
path(path, '../P7')

%%
m              = size(data, 1); 
[X, mu, sigma] = normFeat(data(:, 1:2));
X              = [ones(m, 1), X];
y              = data(:, 3);

%%
alpha          = 0.01;
numIter        = 8000;
initTheta      = zeros(size(X, 2), 1);

%%
[thetaSeq, jSeq] = gradDesVect(X, y, initTheta, alpha, numIter);

%%
figure('name', 'Cost function value trajectory')
plot(1 : numIter, jSeq, 'r-');
xlabel('Iteration step');
ylabel('Cost');

%%
fprintf('Theta computed from gradient descent: \n');
fprintf(' %.5f \n', thetaSeq(:, end));
fprintf('\n');

%%
price = [1, ([1650 3] - mu) ./ sigma] * thetaSeq(:, end);
fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent):\n $%.3f\n'], price);