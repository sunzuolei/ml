clear; clc; close all;
path(path, genpath('../../Codes'));
%%
Theta1 = [-30,  20,  20;
           10, -20, -20];
Theta2 = [-10,  20,  20];
x      = [0, 0; 0, 1; 
          1, 0; 1, 1];
  
%%
m      = size(x, 1);
a1      = [ones(m, 1), x];

z2     = a1 * Theta1';
a2     = [ones(size(z2, 1), 1), sigmoid(z2)];

z3     = a2 * Theta2';
a3     = sigmoid(z3);
%%
fprintf('a2 = \n');
disp(a2(:, 2 : end));
fprintf('a3 = \n');
disp(a3);