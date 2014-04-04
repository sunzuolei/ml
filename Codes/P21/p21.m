clear all; clc; close all;
load '../Data/dataChap4B.mat';
path(path, '../P11')
path(path, '../P18')
path(path, '../P19')

%%
m              = size(data, 1); 
X              = [ones(m, 1), data(:, 1 : end-1)];
y              = data(:, end);

%%
initTheta      = zeros(size(X, 2), 1);

%  Set options for fminunc
optimoptions('fminunc')
options = optimoptions(@fminunc, 'GradObj', 'on',...
    'Display', 'iter-detailed', 'MaxIter', 400,...
    'Algorithm', 'trust-region');% 'trust-region' quasi-newton
%%
%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[optTheta, cost, exitFlag, output] = ...
	fminunc(@(t)(computeCostLog( X, y, t)), initTheta, options);

%%
disp(output);
disp(output.message);
%%
fprintf('Theta computed from fminunc: \n');
fprintf(' %.5f \n', optTheta);
fprintf('\n');

%% Test new data
newData = [40, 70; 80, 80; 65, 40; 90, 35];
dec     = predictLogReg(optTheta, newData);

for i = 1 : size(newData, 1)
   fprintf(['The decision of being admitted'...
    'for a student with the score %.1f, %.1f: \n'...
    '%d \n\n'], newData(i, 1), newData(i, 2), dec(i));
end

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


