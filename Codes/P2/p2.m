clear all; clc; close all;
%%
load '../Data/dataChap2.mat';
x         = data(:, 1);
y         = data(:, 2);

%%
theta0Seq = linspace(-10, 10, 100);
theta1Seq = linspace(-1, 4, 100);
costSeq   = zeros(length(theta0Seq), length(theta1Seq));
r         = 1;

%%
for theta0 = theta0Seq
    c      = 1;
    for theta1 = theta1Seq
        costSeq(r, c) = computeCost(x, y, [theta0, theta1]);
        c  = c + 1;
    end
    r      = r + 1;
end

%%
figure('name', 'The cost function surface')
surf(theta1Seq, theta0Seq, costSeq);
xlabel('\theta_1');
ylabel('\theta_0');
zlabel('Cost function');
colorbar('location', 'northoutside');
% print('costsurf.png', '-dpng');

%%
figure('name', 'The cost function contour')
contour(theta1Seq, theta0Seq, costSeq, 50);
% print('costcontour.png', '-dpng');
colorbar('location', 'eastoutside');