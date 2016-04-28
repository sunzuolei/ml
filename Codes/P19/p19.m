clear all; clc; close all;
load '../Data/dataChap4B.mat';
path(path, '../P11')
path(path, '../P18')

%%
m              = size(data, 1); 
X              = [ones(m, 1), data(:, 1 : end-1)];
y              = data(:, end);

%%
% alpha          = 0.01;
% numIter        = 8000;

% alpha          = 0.001;
% numIter        = 8000;

% alpha          = 0.0005;
% numIter        = 1000000;

% alpha          = 0.0005;
% numIter        = 300;
% Theta computed from gradient descent: 
%  -25.06697 
%  0.20548 
%  0.20071 
%  Elapsed time is 3511.649729 seconds.

alpha          = 0.0008;
numIter        = 30000000;
% Elapsed time is 3920.116274 seconds.
% Theta computed from gradient descent: 
%  -25.15487 
%  0.20618 
%  0.20142 

% alpha          = 0.0005;
% numIter        = 100000000;
initTheta      = zeros(size(X, 2), 1);

%%
[thetaSeq, jSeq] = gradDesLog(X, y, initTheta, alpha, numIter);

optTheta = thetaSeq(:, end);
%%
fprintf('Theta computed from gradient descent: \n');
fprintf(' %.5f \n', optTheta);
fprintf('\n');

%%
figure;
plot(1 : numIter, jSeq, 'r-', 'linewidth', 2);
xlabel('Number of Iteration');
ylabel('Cost');
title(sprintf('\\alpha = %5f, n = %d', alpha, numIter));
grid on;
% print('cost.png', '-dpng');

% thetaSeq(:, end) = [ -24.932998  0.204408  0.199618 ]';
optTheta = [-25.06697; 0.20548; 0.20071]; 

%% Test new data
newData = [40, 70; 80, 80; 65, 40; 90, 35];
dec     = predictLogReg(optTheta, newData);

% for i = 1 : size(newData, 1)
%    fprintf(['The decision of being admitted'...
%     'for a student with the score %.1f, %.1f: \n'...
%     '%d \n\n'], newData(i, 1), newData(i, 2), dec(i));
% end

% A more elegant way to display parallel.
fprintf(['The decision of being admitted'...
'for a student with the score %.1f, %.1f: \n'...
'%d \n\n'], [newData, dec]');

%% Compute accuracy on our training set
p = predictLogReg(optTheta, X(:, 2:end));
fprintf('Train Accuracy: %.2f%%\n', mean(double(p == y)) * 100);

%% Plot decision boundary
% Data
x    = data(:, 1 : end-1);
y    = data(:, end);

iPos = find(y == 1);
xPos = x(iPos, :);
iNeg = find(y == 0);
xNeg = x(iNeg, :);

% Decision boundary
xDec = [min(x(:, 1)), max(x(:, 1))];
yDec = -( optTheta(1) + optTheta(2) * xDec ) / optTheta(3);
%%
figure('name', 'Visualize exam data');
hold on;
plot(xPos(:, 1), xPos(:, 2), '^b', 'Markersize', 10, 'Markerfacecolor', 'y');
plot(xNeg(:, 1), xNeg(:, 2), 'pm', 'Markersize', 13, 'Markerfacecolor', 'g');
plot(xDec,       yDec,       'r-', 'linewidth', 2);
axis equal;
xlim([min(x(:, 1)), max(x(:, 1))]);
ylim([min(x(:, 2)), max(x(:, 2))]);
xlabel('Exam #1');
ylabel('Exam #2');
% print('exam.png', '-dpng');


