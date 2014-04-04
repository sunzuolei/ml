function [J, grad] = computeCostLogReg(X, y, Theta, lambda)
m         = size(y, 1);
n         = size(Theta, 1);
h         = sigmoid(X * Theta);
%% Cost function
J         = -sum(y .* log(h + eps) + (1 - y) .* log(1 - h + eps)) / m...
            + 0.5 * lambda  * (Theta' * Theta) / m;
%% Gradient
grad(1)   = X(:, 1)' * (h - y) / m;
grad(2:n) = X(:, 2 : end)' * (h - y) / m - lambda * Theta(2 : end) / m;