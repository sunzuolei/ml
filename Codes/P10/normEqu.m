function Theta = normEqu(X, y)

Theta = pinv( X' * X ) * X' * y;
