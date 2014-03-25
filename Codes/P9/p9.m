clear all; clc; close all;
load '../Data/dataChap3B.mat';
path(path, '../P7');
path(path, '../P8');

%%
figure('name', 'Visualize the raw data');
rawFig = axes;
plot(data(:, 1), data(:, 2), 'rx',...
    'Linewidth', 2, 'markersize', 8);
hold on;
% print('rawdata.png', '-dpng');

%%
m     = size(data, 1); 
feats = [data(:, 1), data(:, 1).^2, data(:, 1).^3];
%%
figure('name', 'Visualize features')
plot(1 : m, feats(:, 1), 'r-o', ...
     1 : m, feats(:, 2), 'b-x', ...
     1 : m, feats(:, 3), 'g-*');
legend('x', 'x^2', 'x^3');
% print('rawfeats.png', '-dpng');
%%
[featsNorm, mu, sigma] = normFeat(feats);
%%
figure('name', 'Visualize normalized features')
plot(1 : m, featsNorm(:, 1), 'r-o', ...
     1 : m, featsNorm(:, 2), 'b-x', ...
     1 : m, featsNorm(:, 3), 'g-*');
legend('x', 'x^2', 'x^3');
% print('normalizedfeats.png', '-dpng');
%%
X              = [ones(m, 1), featsNorm];
y              = data(:, 2);
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
axes(rawFig);
t = thetaSeq(:, end);
h = t(1) + t(2) * featsNorm(:, 1)... 
         + t(3) * featsNorm(:, 2)...
         + t(4) * featsNorm(:, 3);
plot(data(:, 1), h, 'b-',...
    'Linewidth', 2);
%%
price = [1, ([107, 107^2, 107^3] - mu) ./ sigma] * t;
fprintf(['Predicted price of a 107 sq-m house ' ...
         '(using gradient descent):\n %.3f RMB\n'], price);
axes(rawFig);
plot(107, price, 'og', 'markersize', 15, 'markerfacecolor', 'y');
plot(107, price, '+m', 'markersize', 15);