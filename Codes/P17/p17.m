%% 1st
clear all; close all; clc;
syms h y t1 t0 x0 x1
cost    = y * log(h) + (1 - y) * log(1-h);
costDif = diff(cost, h);
costDif = simplify(costDif);
disp('First:');
pretty(costDif);
fprintf('\n');

%% 2nd
g    = t0 * x0 + t1 * x1;
h    = 1 / (1 + exp( -g ));
hDif = diff(h, t1);
disp('Second:');
pretty(simplify(hDif));
fprintf('\n');

%% 3rd
grad =  hDif / (h * (h - 1));
disp('Third:');
pretty(simplify(grad));
fprintf('\n');