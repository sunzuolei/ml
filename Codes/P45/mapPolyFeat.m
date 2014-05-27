function polyFeats = mapPolyFeat(feats, maxPower)

if size(feats, 2) == 2
   feats = feats(:, 2 : end);
end

polyFeats = [feats, zeros(size(feats, 1), maxPower - 1)];

for i = 2 : maxPower
    polyFeats(:, i) = feats(:, 1) .^ i;
end
