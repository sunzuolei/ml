function [dec, pro] = predictLogReg(optTheta, x)

m   = size(x, 1);
X   = [ones(m, 1), x];
dec = zeros(m, 1);

if length(optTheta) ~= size(X, 2)
   error('Size error!');    
end

pro = sigmoid(X * optTheta);
dec(pro >= 0.5) = 1;