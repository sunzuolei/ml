clear all; close all; clc;

path(path, '../Data');

load dataChap4.mat

%%
x    = data(:, 1);
y    = data(:, 2);

iPos = find(y == 1);
xPos = x(iPos);
iNeg = find(y == 0);
xNeg = x(iNeg);

%%
figure('name', 'Visualize cancer data');
hold on;
plot(xPos, y(iPos), 'ob', 'Markersize', 10, 'Markerfacecolor', 'r');
plot(xNeg, y(iNeg), 'pm', 'Markersize', 13, 'Markerfacecolor', 'g');
grid on;
xlabel('Tumor size (cm)');
ylabel('Diagnosis');
% print('cancerdata.png', '-dpng');
