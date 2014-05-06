function numGrad = compNumGrad(J, theta)           

numGrad = zeros(size(theta));
n       = length(theta);
e       = 1e-4;
for i = 1 : n
    % Set perturbation vector
    tPlus      = theta;
    tMinus     = theta;
    tMinus(i)  = tMinus(i) - e;
    tPlus(i)   = tPlus(i)  + e;
    jMinus     = J(tMinus);
    jPlus      = J(tPlus);
    % Compute Numerical Gradient
    numGrad(i) = (jPlus - jMinus) / ( 2*e );
    fprintf('%.2f%% processed...\n', i / n * 100);
end


