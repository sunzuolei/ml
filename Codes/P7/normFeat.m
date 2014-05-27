function [normX, mu, sigma] = normFeat(X, mu, sigma)

m        = size(X, 1);
if nargin == 2
    error('The sigma should be assigned, if mu is assigned.');
end

if nargin == 1
    mu       = mean(X, 1);
    sigma    = std(X);
end

muSeq    = repmat(mu,    [m, 1]);
sigmaSeq = repmat(sigma, [m, 1]);

normX    = (X - muSeq) ./ sigmaSeq;