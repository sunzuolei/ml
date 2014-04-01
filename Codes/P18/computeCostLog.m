function [J, grad] = computeCostLog(X, y, Theta)
m    = size(y, 1);
h    = sigmoid(X * Theta);
J    = -sum(y .* log(h + eps) + (1 - y) .* log(1 - h + eps)) / m;
grad = X' * (h - y) / m;