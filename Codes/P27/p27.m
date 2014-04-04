clear all; close all; clc;
path(path, genpath('../../Codes'));
load dataChap4C.mat

%%
x    = data(:, 1:2);
y    = data(:, 3);

iPos = find(y == 1);
xPos = x(iPos, 1:2);
iNeg = find(y == 0);
xNeg = x(iNeg, 1:2);

%%
lambda    = 0;
degree    = 6;
feats     = genFeats(x(:, 1), x(:, 2), degree);
%%
initTheta = zeros(size(feats, 2), 1);
%  Set options for fminunc
% optimoptions('fminunc')
options = optimoptions(@fminunc, 'GradObj', 'on',...
    'Display', 'iter-detailed', 'MaxIter', 200,...
    'Algorithm', 'trust-region');% 'trust-region' quasi-newton
%%
%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[optTheta, cost, exitFlag, output] = ...
fminunc(@(t)(computeCostLogReg( feats, y, t, lambda )), initTheta, options);

%%
disp(output);
disp(output.message);
%%
fprintf('Theta computed from fminunc with regularization: \n');
fprintf(' %.5f \n', optTheta);
fprintf('\n');

%% Compute accuracy on our training set
p = predictLogReg(optTheta, feats(:, 2:end));
fprintf('Train Accuracy: %.2f%%\n', mean(double(p == y)) * 100);
%% Test new data
newData  = [0.1, 0.1; -0.5, -0.4];
newfeats = genFeats(newData(:, 1), newData(:, 2), degree);
dec      = predictLogReg(optTheta, newfeats(:, 2 : end));

for i = 1 : size(newData, 1)
   fprintf(['The decision of being past '...
    'for a QA with the two test result %.1f, %.1f: \n'...
    '%d \n\n'], newData(i, 1), newData(i, 2), dec(i));
end
%%
figure('name', 'Logistic regression with regularization');
hold on;
plot(xPos(:, 1), xPos(:, 2), '+b', 'Markersize', 10, 'Linewidth', 3);
plot(xNeg(:, 1), xNeg(:, 2), 'pr', 'Markersize', 13, 'Markerfacecolor', 'y');
xlabel('Microchip QA #1');
ylabel('Microchip QA #2');
% print('qa.png', '-dpng');

%% Plot the decision boundary
m         = 200;
feat1     = linspace(-3, 3, m); 
feat2     = linspace(-3, 3, m); 
feat1Tem  = repmat(feat1, m, 1);
feat1Seq  = reshape(feat1Tem, 1, m * m)';
feat2Seq  = repmat(feat2, 1, m)';

feats     = genFeats(feat1Seq, feat2Seq, degree);
hSeqTem   = feats * optTheta;
hSeq      = reshape(hSeqTem, m, m);
contour(feat1, feat2, hSeq, [0, 0], 'linewidth', 3, 'color', 'r');
axis equal;
xlim([-1, 1.3]);
ylim([-1, 1.3]);
box on;
title(sprintf('\\lambda = %.1f', lambda));
%% Plot new data
plot(newData(:, 1), newData(:, 2), 'o', ...
    'markersize', 10, 'markerfacecolor', 'r', 'markeredgecolor', 'g');
