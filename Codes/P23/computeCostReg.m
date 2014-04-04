function J = computeCostReg(X, y, Theta, lambda)

m = length(y);

J = ((X * Theta - y)' * (X * Theta - y) + ...
    lambda * (Theta' * Theta) ) / (2 * m); 