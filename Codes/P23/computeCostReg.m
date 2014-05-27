function [J, grad] = computeCostReg(X, y, Theta, lambda)

m = length(y);

t = [0; Theta(2 : end)];
J = ((X * Theta - y)' * (X * Theta - y) + ...
    lambda * (t' * t) ) / (2 * m); 

%% Compute the gradient for the built-in optimization function
grad = X' * (X * Theta - y) / m + lambda * t / m;