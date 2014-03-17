function j = computeCost(x, y, theta)

h = theta(1) + theta(2) * x;

j = sum((h - y).^2 ) / (2 * length(x));