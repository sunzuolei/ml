clear all; clc; close all;
load '../Data/dataChap4.mat';
path(path, '../P11')
path(path, '../P19')
path(path, '../P18')

%%
m              = size(data, 1); 
X              = [ones(m, 1), data(:, 1 : end-1)];
y              = data(:, end);

%%
initTheta      = zeros(size(X, 2), 1); % -14.2  2.1

%%
%  Set options for fminunc
optimoptions('fminunc')
options = optimoptions(@fminunc, 'GradObj', 'on',...
    'Display', 'iter-detailed', 'MaxIter', 400,...
    'Algorithm', 'quasi-newton');% 'trust-region'
%%
%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[optTheta, cost, exitFlag, output] = ...
	fminunc(@(t)(computeCostLog( X, y, t)), initTheta, options);

%%
fprintf('Theta computed from fminunc: \n');
fprintf(' %.5f \n', optTheta);
fprintf('\n');


%% Test new data
newData = [9.2; 4.7; 6.9; 3.2];
dec     = predictLogReg(optTheta, newData);

for i = 1 : size(newData, 1)
   fprintf('The decision of being malignant for a %.2f tumor:\n', newData(i));
   fprintf(' %d \n\n', dec(i)); 
end
%%
p = predictLogReg(optTheta, X(:, 2:end));
fprintf('Train Accuracy: %.2f%%\n', mean(double(p == y)) * 100);

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

