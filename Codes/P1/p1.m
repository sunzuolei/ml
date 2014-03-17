clear all; clc; close all;

load '../Data/dataChap2.mat';
figure('name', 'The data visualization')
plot(data(:, 1), data(:, 2), 'rx', 'markersize', 10, 'linewidth', 2);
grid on;
box on;
set(gca, 'xgrid', 'off');
xlabel('House size in m^2');
ylabel('House price in $');
print('data.png', '-dpng');
