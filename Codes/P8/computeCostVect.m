function [J, g] = computeCostVect(X, y, Theta)

% J = sum( (X * Theta - y).^2 )/ 2 * length(y);
m = length(y);
J = (X * Theta - y)' * (X * Theta - y) / ( 2 * m );
g =  X' * (X * Theta - y) / m;