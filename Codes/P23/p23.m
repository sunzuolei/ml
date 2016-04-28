clear all; clc; close all;
path(path, '../P7');
path(path, '../P8');
load '../Data/dataChap2.mat';
%%
data = data(40: 46, :);
[data(:, 1), i] = sort(data(:, 1));
yTemp           = data(:, 2);
data(:, 2)      = yTemp(i);

%%
m     = size(data, 1); 
f     = data(:, 1);
feats = [f, f.^2, f.^3, f.^4, f.^5, f.^6, f.^7];
%%
% featsNorm = feats;
[featsNorm, mu, sigma] = normFeat(feats);

%%
X              = [ones(m, 1), featsNorm];
y              = data(:, 2);
%%
alpha          = 0.01;
numIter        = 8000;
initTheta      = zeros(size(X, 2), 1);
% ==============================================
%% Just right
[thetaSeqRight, jSeqRight] = ...
    gradDesVect(X(:, 1:2), y, initTheta(1:2), alpha, numIter);
%% Over fitting
[thetaSeqOver, jSeqOver] = gradDesVect(X, y, initTheta, alpha, numIter);
%% Gradient decent with regularization
lambda = 0.1;
[thetaSeqReg, jSeqReg] = gradDesReg(X, y, initTheta, alpha, lambda, numIter);
% ==============================================
%%
fprintf('Just right Theta : \n');
fprintf(' %.5f \n', thetaSeqRight(:, end));
fprintf('\n');
fprintf('Over fit Theta : \n');
fprintf(' %.5f \n', thetaSeqOver(:, end));
fprintf('\n');
fprintf('Regularization Theta : \n');
fprintf(' %.5f \n', thetaSeqReg(:, end));
fprintf('\n');
%%
figure(1);
title('Linear regression without regularization')
plot(data(:, 1), data(:, 2), 'rx',...
    'Linewidth', 2, 'markersize', 8);
hold on;
%
t      = thetaSeqOver(:, end);
hOver = t(1)  + t(2) * featsNorm(:, 1)... 
              + t(3) * featsNorm(:, 2)...
              + t(4) * featsNorm(:, 3)...
              + t(5) * featsNorm(:, 4)...
              + t(6) * featsNorm(:, 5)...
              + t(7) * featsNorm(:, 6)...
              + t(8) * featsNorm(:, 7);
figOver = plot(data(:, 1), hOver, 'g-', 'Linewidth', 2);
%
t      = thetaSeqRight(:, end);
hRight = t(1) + t(2) * featsNorm(:, 1);
figRight = plot(data(:, 1), hRight, 'b-', 'Linewidth', 2);
legend([figRight, figOver], ...
        'h=\theta_0+\theta_1x',...
'h=\theta_0+\theta_1x+\theta_2 x^2+\theta_3 x^3+\theta_4 x^4+\theta_5 x^5+\theta_6 x^6+\theta_7 x^7' );
% pause;
% print('noreg', '-dpng');
%% Regularization
title('Linear regression with regularization')
t     = thetaSeqReg(:, end);
hReg  = t(1)  + t(2) * featsNorm(:, 1)... 
              + t(3) * featsNorm(:, 2)...
              + t(4) * featsNorm(:, 3)...
              + t(5) * featsNorm(:, 4)...
              + t(6) * featsNorm(:, 5)...
              + t(7) * featsNorm(:, 6)...
              + t(8) * featsNorm(:, 7);
figReg = plot(data(:, 1), hReg, 'm-', 'Linewidth', 2);
legend(figReg, ['Regularized h \lambda=', num2str(lambda, '%.2f')]);
print(['withreg', num2str(lambda, '%.2f'), '.png'], '-dpng');
