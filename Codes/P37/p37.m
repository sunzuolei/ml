clear all; close all; clc;

path(path, genpath('../../Codes'));

load dataChap4D
load dataChap6
%% 
m          = length(y);
sizeOut    = 10;
lambda     = 0;
T2         = Theta2( :, 2 : end);

%% Remap y
yNew       = zeros(sizeOut * m, 1);
iOne       = (0 : (m - 1)) * sizeOut +  y';
yNew(iOne) = 1;
yNew       = reshape(yNew, sizeOut, []);

%% forward propagation
[~, ~, act]= forwProp3Layer(X, Theta1, Theta2);

%% Backpropagation 
delta3     = act.a3 - yNew;
gDiff2     = exp(-act.z2) ./ (exp(-act.z2) + 1).^2;
delta2     = T2' * delta3 .* gDiff2;
%%
Delta2     = delta3 * act.a2';
Delta1     = delta2 * act.a1';
%%
T1         = [zeros(size(Theta1,1),1), Theta1(:,2:end)];
T2         = [zeros(size(Theta2,1),1), Theta2(:,2:end)];
gradTheta1 = 1 / m * Delta1 + lambda / m * T1;
gradTheta2 = 1 / m * Delta2 + lambda / m * T2;

%% Unrolling 
grad       = [gradTheta1(:); gradTheta2(:)];