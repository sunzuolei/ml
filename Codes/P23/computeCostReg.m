function J = computeCostReg(X, y, Theta, lambda)

m = length(y);

t = [0; Theta(2 : end)];
J = ((X * Theta - y)' * (X * Theta - y) + ...
    lambda * (t' * t) ) / (2 * m); 