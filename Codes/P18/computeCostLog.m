function [J, grad] = computeCostLog(X, y, Theta)
m    = size(y, 1);
h    = sigmoid(X * Theta);
J    = -sum(y .* log(h) + (1 - y) .* log(1 - h)) / m;
grad = X' * (h - y) / m;