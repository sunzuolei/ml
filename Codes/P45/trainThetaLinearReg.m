function optTheta = trainThetaLinearReg(x, y, lambda, numIter)

if nargin < 4
   numIter = 200; 
end

initTheta = zeros(size(x, 2), 1);
options   = optimset('MaxIter', numIter, 'GradObj', 'on');
optTheta  = fmincg(@(t)computeCostReg(x, y, t, lambda),...
            initTheta, options);