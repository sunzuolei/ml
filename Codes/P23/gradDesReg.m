function [thetaSeq, jSeq] = gradDesReg(X, y, initTheta, alpha, lambda, numIter)
%%
m              = length(y);
thetaSeq       = zeros(length(initTheta), numIter);
jSeq           = zeros(numIter, 1);
%%
thetaSeq(:, 1) = initTheta;
jSeq(1)        = computeCostVect(X, y, initTheta);

for i = 2 : numIter
    thetaSeq(1, i) = thetaSeq(1, i-1) - ...
                     alpha / m * (X(:, 1)' * (X * thetaSeq(:, i-1) - y));
    thetaSeq(2:end, i) = thetaSeq(2:end, i-1) * (1 - alpha * lambda / m) - ...
                   alpha / m * (X(:, 2:end)' * (X * thetaSeq(:, i-1) - y));
    jSeq(i)        = computeCostReg(X, y, thetaSeq(:, i), lambda);
end
