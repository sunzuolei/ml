clear all; close all; clc;

path(path, '../P11');
path(path, '../Data');

load dataChap4C.mat

%%
x    = data(:, 1:2);
y    = data(:, 3);

iPos = find(y == 1);
xPos = x(iPos, 1:2);
iNeg = find(y == 0);
xNeg = x(iNeg, 1:2);

%%
figure('name', 'Visualize qa data');
hold on;
plot(xPos(:, 1), xPos(:, 2), '+b', 'Markersize', 10, 'Linewidth', 3);
plot(xNeg(:, 1), xNeg(:, 2), 'pr', 'Markersize', 13, 'Markerfacecolor', 'y');
xlabel('Microchip QA #1');
ylabel('Microchip QA #2');
% print('qa.png', '-dpng');

%%
figure('name', 'Visualize qa data 3D');
hold on;
plot3(xPos(:, 1), xPos(:, 2), y(iPos), '+b', ...
    'Markersize', 10, 'Linewidth', 3);
plot3(xNeg(:, 1), xNeg(:, 2), y(iNeg), 'pr', ...
    'Markersize', 13, 'Markerfacecolor', 'y');
grid on;
box  on;
xlabel('Microchip QA #1');
ylabel('Microchip QA #2');
zlabel('Pass');
view ([-118 44])
% print('qa3d.png', '-dpng');
