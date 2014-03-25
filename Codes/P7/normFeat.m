function [normX, mu, sigma] = normFeat(X)

m        = length(X);
mu       = mean(X, 1);
sigma    = std(X);

muSeq    = repmat(mu,    [m, 1]);
sigmaSeq = repmat(sigma, [m, 1]);

normX    = (X - muSeq) ./ sigmaSeq;