function thetaCell = rollTheta(thetaVec, structNN)

numLayer      = length(structNN);
thetaCell     = cell( numLayer-1, 1 );
nodNextLayer  = structNN(2 : end);
nodPrevLayer  = structNN(1 : end-1) + 1;
numNode       = nodNextLayer .* nodPrevLayer;
iStart        = 1;
iEnd          = numNode(1);
for i = 1 : numLayer - 1
    thetaCell{i} = reshape(thetaVec(iStart : iEnd ),...
                        nodNextLayer(i), nodPrevLayer(i));
    if i < numLayer - 1
        iStart    = iEnd + 1;
        iEnd      = iStart + numNode(i + 1) - 1; 
    end
end