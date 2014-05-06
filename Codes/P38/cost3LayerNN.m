function [cost, grad] = cost3LayerNN(thetaVec,...
                                     sizeIn, sizeHid, sizeOut,...
                                     X, y, lambda)
%% Roll the thetaVec again
Theta1     = reshape(thetaVec(1 : sizeHid * (sizeIn+1) ),...
                     sizeHid, sizeIn+1);
Theta2     = reshape(thetaVec(sizeHid * (sizeIn+1) + 1 : end ),...
                     sizeOut, sizeHid + 1);

%% Remap y
m          = length(y);
yNew       = zeros(sizeOut * m, 1);
iOne       = (0 : (m - 1)) * sizeOut +  y';
yNew(iOne) = 1;
yNew       = reshape(yNew, sizeOut, []);

%% Forward propagation
[~, ~, act]= forwProp3Layer(X, Theta1, Theta2);

%% Compute the cost
j          = yNew .* log(act.a3) + (1 - yNew) .* log(1 - act.a3);
j          = - sum(j(:)) / m;

%% Regularization
T1         = Theta1( :, 2 : end);
T2         = Theta2( :, 2 : end);
r          = lambda / 2 * ( sum(T1(:).^ 2) + sum(T2(:).^ 2) ) / m;
cost       = j + r;

%% Compute the gradient with backpropagation
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

%% Unroll the gradient
grad       = [gradTheta1(:); gradTheta2(:)];