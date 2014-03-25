function J = computeCostVect(X, y, Theta)

% J = sum( (X * Theta - y).^2 )/ 2 * length(y);

J = (X * Theta - y)' * (X * Theta - y) / 2 * length(y);