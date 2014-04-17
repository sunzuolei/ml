function [dec, pro] = pred3layerNN(x, Theta1, Theta2)

a1     = [ones(size(x, 1), 1), x];

z2     = a1 * Theta1';
a2     = [ones(size(z2, 1), 1), sigmoid(z2)];

z3     = a2 * Theta2';
a3     = sigmoid(z3);


%%
[pro, dec] = max( a3, [], 2);