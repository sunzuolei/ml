clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4B;

%%
thetaVec = [-24.93300; 0.20441; 0.19962]; 
m        = size(data, 1); 
X        = [ones(m, 1), data(:, 1 : end-1)];
y        = data(:, end);
%%

[~, grad] = computeCostLog( X, y, thetaVec);

%%
numGrad   = compNumGrad(@(t)(computeCostLog( X, y, t)), thetaVec);

%%
diff      = norm(numGrad-grad) / norm(numGrad+grad);
diff2     = mean( abs(numGrad -grad) );
disp(numGrad);
disp(grad);
disp(diff2);

