function theta = initWeightNN(sizePreviousLayer, sizeCurrentLayer)

epsInit = sqrt(6) / sqrt(sizePreviousLayer + sizeCurrentLayer);
theta   = rand(sizeCurrentLayer, 1 + sizePreviousLayer) * 2 * epsInit...
                                                            - epsInit;