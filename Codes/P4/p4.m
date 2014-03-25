clear all; clc; close all;
load '../Data/dataChap3.mat';
%%
x = data(:, 1:2);
y = data(:, 3);
m = size(x, 1);
% m = length(y);
%%
disp(x);
disp(y);
%%
X = [ones(m,1), x]';
disp(X);

%%
syms theta0 theta1 theta2
Theta = [theta0; theta1; theta2];
disp(Theta);

%%
h1 = Theta' * X(:,1);
h2 = X(:,1)' * Theta;
disp('h1 = '); 
disp(h1);
disp('h2 = '); 
disp(h2);

%%
hMulti = X' * Theta;
disp(X');
disp(Theta);
disp('hMulti = ');
disp(hMulti);

%%
hMulti = [ones(m,1), x] * Theta;
disp(hMulti);