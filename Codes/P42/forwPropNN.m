function [dec, pro, aCell, zCell] = forwPropNN(x, tCell, structNN)

numAct   = length(structNN);
aCell    = cell(numAct, 1);
zCell    = cell(numAct, 1);
aCell{1} = [ones(1, size(x, 1)); x'];

for i   = 2 : numAct
    zCell{i} = tCell{i - 1} * aCell{i - 1};
    if i == numAct
        aCell{i} = sigmoid( zCell{i} );
    else
        aCell{i} = [ones(1, size(zCell{i}, 2)); ...
                       sigmoid(zCell{i})];
    end        
end

if structNN(end) == 1
    dec = zeros(1, size(x, 1));    
    dec(aCell{end} >0.5 ) = 1;
    pro = aCell{end};
else
    [pro, dec] = max( aCell{end} );
end

pro        = pro';
dec        = dec';


% a1         = [ones(1, size(x, 1)); x'];
% z2         = Theta1 * a1;
% a2         = [ones(1, size(z2, 2)); sigmoid(z2)];
% 
% z3         = Theta2 * a2;
% a3         = sigmoid(z3);
% 
% [pro, dec] = max( a3 );
% 
% pro        = pro';
% dec        = dec';
% 
% act        = struct('a1', a1, 'z2', z2, 'a2', a2, 'z3', z3, 'a3', a3);