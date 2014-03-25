path(path, '../P8');
p8;
close all;
%%
X     = [ones(m, 1), data(:, 1:2)];
Theta = normEqu(X, y);

%%
fprintf('\n Theta computed from normal equation: \n');
fprintf(' %.5f \n', Theta);
fprintf('\n');

%%
price = [1, 1650,  3] * Theta;
fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using normal equation):\n $%.3f\n'], price);