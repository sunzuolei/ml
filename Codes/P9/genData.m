clear all; clc; close all;
rng(555);

%%
theta0 = 110000;
theta1 = 15;
theta2 = 1.3;
theta3 = 0.6;
x      = 0 : 0.1 : 150;
h      = theta0 + theta1 * x + theta2 * x .^2 + theta3 * x .^3;
%%
figure(1)
plot(x, h, 'b-');
hold on;

xMax  = 140;
xMin  = 50;
m     = 70;
sigma = 50000;

x = xMin + (xMax - xMin).* rand(52, 1);
h = theta0 + theta1 * x + theta2 * x .^2 + theta3 * x .^3; 
h = h + sigma * randn(size(h));
plot(x, h, 'rx');
%%
[x, i] = sort(x);
data   = [x, h(i)];
save( '../Data/dataChap3B.mat', 'data' );