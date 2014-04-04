clear all; close all; clc;

syms x1 x2 
degree   = 6;
numTheta = sum( 1 : (degree + 1) );
fprintf('%d theta needed, when degree=%d.\n\n', ...
        numTheta, degree);
    
for i = 1 : degree
   fprintf('==== i=%d ===\n', i)
   for j = 0 : i
       pretty(x1^(i-j) * x2^j);
   end
end