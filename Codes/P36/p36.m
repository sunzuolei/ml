clear; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4D
load dataChap6

%%
idx        = [2, 1888, 4999];
X          = X(idx, :);
y          = y(idx, :);

m          = length(y);
sizeOut    = 10;
lambda     = 1;

%% Remap y
yNew       = zeros(sizeOut * m, 1);
iOne       = (0 : (m - 1)) * sizeOut +  y';
yNew(iOne) = 1;
yNew       = reshape(yNew, sizeOut, []);

%% Forward propagation
[~, ~, act]= forwProp3Layer(X, Theta1, Theta2);
%% Compute the cost
j          = yNew .* log(act.a3) + (1 - yNew) .* log(1 - act.a3);
j          = - sum(j(:)) / m;
fprintf( 'The cost function value without regularization: %.4f \n', j);

%% Regularization
T1         = Theta1( :, 2 : end);
T2         = Theta2( :, 2 : end);
r          = lambda / 2 * ( sum(T1(:).^ 2) + sum(T2(:).^ 2) ) / m;
j          = j + r;
fprintf( 'The regularized cost function value: %.4f \n', j);
