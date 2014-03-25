% Test the cost function value without theta0
% NOTE: theta0 is not considered here!

clear all; clc; close all;
load '../Data/dataChap3.mat';
%%
x = data(:, 1:2);
y = data(:, 3);
m = size(x, 1);
a = 100;
b = 110;

%%  
X = x;

%%
theta1Seq = linspace(-3000, 3000, a);
theta2Seq = linspace(-5000, 5000, b);

%%
costSeq   = zeros(a, b);
r         = 1;

%%
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


%%
figure('name', 'The PARTIAL cost function surface')
surf(theta2Seq, theta1Seq, costSeq);
xlabel('\theta_2');
ylabel('\theta_1');
zlabel('PARTIAL Cost function');
colorbar('location', 'northoutside');

%%
figure('name', 'The PARTIAL cost function contour')
contour(theta1Seq, theta2Seq, costSeq', 100);
xlabel('\theta_1');
ylabel('\theta_2');
% print('costcontour.png', '-dpng');
colorbar('location', 'eastoutside');