clear all; clc; close all;
load '../Data/dataChap4.mat';
path(path, '../P11')
path(path, '../P19')

%%
m              = size(data, 1); 
X              = [ones(m, 1), data(:, 1 : end-1)];
y              = data(:, end);

%%
alpha          = 0.0005;
numIter        = 1000000;
initTheta      = zeros(size(X, 2), 1); % -14.2  2.1
% Elapsed time is 1055.017954 seconds.
% Theta computed from gradient descent: 
%  -26.10616 
%  3.82259 
% alpha          = 0.0005;
% numIter        = 10000000;

%%
[thetaSeq, jSeq] = gradDesLog(X, y, initTheta, alpha, numIter);

%%
optTheta = thetaSeq(:, end);

%%
fprintf('Theta computed from gradient descent: \n');
fprintf(' %.5f \n', optTheta);
fprintf('\n');

%%
figure;
plot(1 : numIter, jSeq, 'r-', 'linewidth', 3);
xlabel('Number of Iteration');
ylabel('Cost');
grid on;
% print('cost.png', '-dpng');

%% Test new data
newData = [9.2; 4.7; 6.9; 3.2];
dec     = predictLogReg(optTheta, newData);

for i = 1 : size(newData, 1)
   fprintf('The decision of being malignant for a %.2f tumor:\n', newData(i));
   fprintf(' %d \n\n', dec(i)); 
end

%% Plot decision boundary
% Data
x    = data(:, 1);
y    = data(:, 2);

iPos = find(y == 1);
xPos = x(iPos);
iNeg = find(y == 0);
xNeg = x(iNeg);

% Calculate boundary
xDec = -optTheta(1) / optTheta(2) * [1, 1];
yDec = [0, 1];

figure('name', 'Visualize cancer data');
hold on;
plot(xPos, y(iPos), 'ob', 'Markersize', 10, 'Markerfacecolor', 'r');
plot(xNeg, y(iNeg), 'pm', 'Markersize', 13, 'Markerfacecolor', 'g');
plot(xDec, yDec,    'r-', 'linewidth', 2);
grid on;
xlabel('Tumor size (cm)');
ylabel('Diagnosis');

