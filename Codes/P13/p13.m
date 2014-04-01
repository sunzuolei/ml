clear all; close all; clc;

path(path, '../P11');
path(path, '../Data');

load dataChap4B.mat

%%
x    = data(:, 1:2);
y    = data(:, 3);

iPos = find(y == 1);
xPos = x(iPos, 1:2);
iNeg = find(y == 0);
xNeg = x(iNeg, 1:2);

%%
figure('name', 'Visualize exam data');
hold on;
plot(xPos(:, 1), xPos(:, 2), '^b', 'Markersize', 10, 'Markerfacecolor', 'y');
plot(xNeg(:, 1), xNeg(:, 2), 'pm', 'Markersize', 13, 'Markerfacecolor', 'g');
xlabel('Exam #1');
ylabel('Exam #2');
% print('exam.png', '-dpng');

%%
figure('name', 'Visualize exam data 3D');
hold on;
plot3(xPos(:, 1), xPos(:, 2), y(iPos), '^b', ...
    'Markersize', 10, 'Markerfacecolor', 'y');
plot3(xNeg(:, 1), xNeg(:, 2), y(iNeg), 'pm', ...
    'Markersize', 13, 'Markerfacecolor', 'g');
grid on;
box  on;
xlabel('Exam #1');
ylabel('Exam #2');
zlabel('Admission');
view ([-118 44])
% print('exam3d.png', '-dpng');
