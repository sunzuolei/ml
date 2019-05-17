clear; clc; close all;
%%
load '../Data/dataChap2.mat';
path(path, '../P2');

x         = data(:, 1);
y         = data(:, 2);

%%
theta     = [0, 0];
alpha     = 0.02;
numIter   = 1500;

%%
[costSeq, theta0Seq, theta1Seq] = gradDes(x, y, alpha, theta, numIter);

%% print theta to screen
fprintf('Theta found by gradient descent: ');
fprintf('%f %f \n', theta0Seq(end), theta1Seq(end));

%% Predict the new data
price = theta1Seq(end) * 35 + theta0Seq(end);
fprintf('For house size = 35, we predict a price of %f\n',...
    price);
price = theta1Seq(end) * 70 + theta0Seq(end);
fprintf('For house size = 70, we predict a price of %f\n',...
    price);

%%
figure('name', 'Cost function values')
plot(1 : numIter, costSeq, 'b-');
hold on;
plot(1 : numIter, costSeq, 'r.');
xlabel('Iteration step');
ylabel('Cost function value');

%%
figure('name', 'The data visualization')
plot(x, y, 'bx', 'markersize', 10, 'linewidth', 1.5);
hold on;
plot(x, theta1Seq(end)* x + theta0Seq(end), 'r-', 'linewidth', 2)
grid on;
box on;
set(gca, 'xgrid', 'off');
xlabel('House size in m^2');
ylabel('House price in 1000$');

%%
figure('name', 'The trajectory of the GD')
plot3(theta1Seq, theta0Seq, costSeq, '*r');
grid on;
box on;