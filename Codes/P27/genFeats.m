function feats = genFeats(x1, x2, degree)
%%
if size(x1, 2) ~= 1 || size(x1, 2) ~= 1
   error('x1 and x2 should be column vector!'); 
end
%%
numFeat  = sum( 1 : (degree + 1) );
numSamp  = length(x1); 
feats    = ones(numSamp, numFeat);
%%
c        = 2;
for i = 1 : degree
    for j = 0 : i
        feats(:, c) = ( x1.^(i-j) ) .* ( x2.^j );
        c = c + 1;
    end
end
