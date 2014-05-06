function [dec, pro, act] = forwProp3Layer(x, Theta1, Theta2)

% a1         = [ones(size(x, 1), 1), x];
% 
% z2         = a1 * Theta1';
% a2         = [ones(size(z2, 1), 1), sigmoid(z2)];
% 
% z3         = a2 * Theta2';
% a3         = sigmoid(z3);
% 
% [pro, dec] = max( a3, [], 2);

%% The following implementation imits the same result
a1         = [ones(1, size(x, 1)); x'];

z2         = Theta1 * a1;
a2         = [ones(1, size(z2, 2)); sigmoid(z2)];

z3         = Theta2 * a2;
a3         = sigmoid(z3);

[pro, dec] = max( a3 );

pro        = pro';
dec        = dec';

act        = struct('a1', a1, 'z2', z2, 'a2', a2, 'z3', z3, 'a3', a3);