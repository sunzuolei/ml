function [J, grad] = computeCostLogReg(X, y, Theta, lambda)
m         = size(y, 1);
n         = size(Theta, 1);
% grad      = zeros(n, 1);
h         = sigmoid(X * Theta);
T         = Theta;
T(1)      = 0;
%% Cost function
J         = -sum(y .* log(h) + (1 - y) .* log(1 - h)) / m...
            + 0.5 * lambda  * (T' * T) / m;
%% Gradient
% grad(1)   = X(:, 1)' * (h - y) / m;
% grad(2:n) = X(:, 2 : end)' * (h - y) / m + lambda * Theta(2 : end) / m;

grad      = X' * (h - y) / m + lambda * T / m;

% grad = grad';