% Test the cost function value without theta0
% NOTE: theta0 is not considered here!

clear all; clc; close all;
load '../Data/dataChap3.mat';
%%
x = data(:, 1:2);
y = data(:, 3);
m = size(x, 1);
a = 1000;
b = 1200;

%%  
X = x;

%%
theta1Seq = linspace(-3000, 3000, a);
theta2Seq = linspace(-5000, 5000, b);

%%
costSeq   = zeros(a, b);
r         = 1;

%%
startLoop = tic;
for theta1 = theta1Seq
    c      = 1;
    for theta2 = theta2Seq
        Theta  = [theta1; theta2];
        h      = X * Theta;
        costSeq(r, c) ...
               = sum((h - y).^2 ) / (2 * m);         
        c  = c + 1;
    end
    r      = r + 1;
end
timeLoop = toc(startLoop);

%% Vectorization
startVec     = tic;
theta1SeqTem = repmat (theta1Seq, [b, 1]);
theta1SeqTem = reshape(theta1SeqTem, 1, []);
theta2SeqTem = repmat (theta2Seq, [1, a]);
ThetaSeq     = [theta1SeqTem; theta2SeqTem];
hSeq         = X * ThetaSeq; 
ySeq         = repmat (y, [1, a*b]);
costSeqTem   = sum((hSeq - ySeq).^2) / (2 * m);
costSeqVec   = reshape(costSeqTem, [b, a])';

timeVec      = toc(startVec);

%%
testEqual    = sum(sum(costSeqVec - costSeq));
%%
disp(testEqual);
fprintf('The "for loop" takes %.2f seconds.\n', timeLoop);
fprintf('The vectorized operation takes %.2f seconds.\n', timeVec);
