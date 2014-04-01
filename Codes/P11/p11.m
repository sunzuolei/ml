close all; clear all; clc;

z = -20 : 0.01 : 20;
g = sigmoid(z);

figure('name', 'Sigmoid function')
plot(z, g, 'r-', 'linewidth', 3);
grid on
% print('sigmoid.png', '-dpng');