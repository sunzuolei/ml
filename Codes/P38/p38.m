clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4D
load dataChap6

%%
thetaVec  = [Theta1(:); Theta2(:)];
sizeIn    = 400;
sizeHid   = 25;
sizeOut   = 10;
lambda    = 0;
%%
tic;
[~, grad] = cost3LayerNN(thetaVec,sizeIn, sizeHid, sizeOut,...
               X, y, lambda);
toc;
%%
tic;
numGrad   = compNumGrad(@(t)cost3LayerNN(t, sizeIn, sizeHid,...
            sizeOut, X, y, lambda), thetaVec);
toc;

%%
diff      = norm(numGrad-grad) / norm(numGrad+grad);
diff2     = mean( abs(numGrad -grad) );
disp(diff2);
