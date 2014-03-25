function [thetaSeq, jSeq] = gradDesVect(X, y, initTheta, alpha, numIter)
%%
m              = length(y);
thetaSeq       = zeros(length(initTheta), numIter);
jSeq           = zeros(numIter, 1);
%%
thetaSeq(:, 1) = initTheta;
jSeq(1)        = computeCostVect(X, y, initTheta);

for i = 2 : numIter
    thetaSeq(:, i) = thetaSeq(:, i-1) - ...
                     alpha / m * (X' * (X * thetaSeq(:, i-1) - y));
    jSeq(i)        = computeCostVect(X, y, thetaSeq(:, i));
end
