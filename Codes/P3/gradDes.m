function [costSeq, t0Seq, t1Seq] = gradDes(...
                        x, y, alpha, theta, numIter)

m       = length(x);
theta0  = theta (1);
theta1  = theta (2);

costSeq = zeros(numIter, 1);
t0Seq   = zeros(numIter, 1);
t1Seq   = zeros(numIter, 1);

for i = 1 : numIter
    h         = theta0 + theta1 * x;
    theta0Tem = theta0 - alpha / m * sum(h - y);
    theta1Tem = theta1 - alpha / m * sum((h - y).* x);
    
    costSeq(i)= computeCost(x, y, [theta0Tem, theta1Tem]);
    
    theta0    = theta0Tem;
    theta1    = theta1Tem;
    
    t0Seq(i)  = theta0;
    t1Seq(i)  = theta1;
end