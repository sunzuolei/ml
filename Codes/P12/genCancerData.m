%%
clear all; clc; close all;

path(path, '../P11');
rng(777);
%%
m    = 40;
xMin = 3;
xMax = 12;
x    = xMin + (xMax - xMin) * rand(m, 1);
x    = sort(x);
% x    = -10 : 0.01 : 10;
%%
t0   = -14.2;
t1   = 2.1;
h    = t0 + t1 * x;
g    = sigmoid(h);

%%
figure
hold on
plot(x, g, 'ro-');
grid on
%%
iPos    = find(g >= 0.5);
y(iPos) = 1;
iNeg    = find(g <  0.5);
y(iNeg) = 0;

figure
hold on
plot(x, y, 'r*');
grid on
%%
data = [x, y'];
save('../Data/dataChap4.mat', 'data');

