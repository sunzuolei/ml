function [thetaSeq, jSeq] = gradDesLog(X, y, initTheta, alpha, numIter)
%%
tic;
thetaSeq       = zeros(length(initTheta), numIter);
jSeq           = zeros(numIter, 1);
m              = length(y);
%%
thetaSeq(:, 1) = initTheta;
jSeq(1)        = computeCostLog(X, y, initTheta);
%%
for i = 2 : numIter
    h              = sigmoid(X * thetaSeq(:, i-1) );
    thetaSeq(:, i) = thetaSeq(:, i-1) - ...
                     alpha * (X' * (h - y)) / m;
    jSeq(i)        = computeCostLog(X, y, thetaSeq(:, i));
    fprintf('Gradient descending %.4f %%\n', i/numIter * 100);
end
toc;
