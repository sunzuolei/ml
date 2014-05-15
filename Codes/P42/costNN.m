function [cost, grad] = costNN(thetaVec, structNN, X, y, lambda)
numLayer   = length(structNN);
%% Roll the thetaVec again
thetaCell  = rollTheta(thetaVec, structNN);
m          = length(y);
%% Remap y
if structNN(end) ~= 1
    yNew       = zeros(structNN(end) * m, 1);
    iOne       = (0 : (m - 1)) * structNN(end) +  y';
    yNew(iOne) = 1;
    yNew       = reshape(yNew, structNN(end), []);
else
    yNew       = reshape(y, 1, []);
end

%% Forward propagation
[~, ~, aCell, zCell]= forwPropNN(X, thetaCell, structNN);

%% Compute the cost
j          = yNew .* log( aCell{end} ) + (1 - yNew) .* log(1 - aCell{end});
j          = - sum(j(:)) / m;

%% Regularization
sumTheta   = 0;
for i = 1 : numLayer-1
    thetaTemp = thetaCell{i};
    thetaTemp = thetaTemp( :, 2 : end);
    sumTheta  = sumTheta + sum( thetaTemp(:).^2 );
end
cost = j + lambda / 2 * sumTheta / m;
% T1         = Theta1( :, 2 : end);
% T2         = Theta2( :, 2 : end);
% r          = lambda / 2 * ( sum(T1(:).^ 2) + sum(T2(:).^ 2) ) / m;
% cost       = j + r;

%% Compute the gradient with backpropagation
deltaCell       = cell(numLayer, 1);
deltaCell{end}  = aCell{end} - yNew;
gradCell        = cell(numLayer-1, 1);
for i = (numLayer - 1) : -1 : 1
    gDiff = exp( -zCell{i} ) ./ (exp(-zCell{i}) + 1).^2;
    thetaTemp = thetaCell{i};
    thetaTemp = thetaTemp( :, 2 : end);
    if i > 1
        deltaCell{i} = thetaTemp' * deltaCell{ i + 1 } .* gDiff;        
    end
    Delta       = deltaCell{ i + 1 } * aCell{i}';   
    thetaTemp2  = [zeros(size(thetaTemp, 1), 1), thetaTemp ];
    gradCell{i} = 1 / m * Delta + lambda / m * thetaTemp2;
end
% delta3     = act.a3 - yNew;
% gDiff2     = exp(-act.z2) ./ (exp(-act.z2) + 1).^2;
% delta2     = T2' * delta3 .* gDiff2;
% %%
% Delta2     = delta3 * act.a2';
% Delta1     = delta2 * act.a1';
% %%
% T1         = [zeros(size(Theta1,1),1), Theta1(:,2:end)];
% T2         = [zeros(size(Theta2,1),1), Theta2(:,2:end)];
% gradTheta1 = 1 / m * Delta1 + lambda / m * T1;
% gradTheta2 = 1 / m * Delta2 + lambda / m * T2;

%% Unroll the gradient
grad = [];
for i = 1 : numLayer-1
    gradSing = gradCell{i};
    grad     = [grad; gradSing(:)];
end
% grad       = [gradTheta1(:); gradTheta2(:)];