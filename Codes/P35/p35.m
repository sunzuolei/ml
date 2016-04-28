clear; close all; clc;

syms z g
g = 1 / (1 + exp(-z) );
gDiff = diff(g, z);
gDiff = simplify(gDiff);
pretty(gDiff);

%      exp(-z) 
%   -------------- 
%                2 
%   (exp(-z) + 1)