clear all; close all; clc;

path(path, '../P11');
path(path, '../Data');

load dataChap4.mat

%%
x    = data(:, 1);
y    = data(:, 2);
m    = length(y);

%%
a            = 60;
b            = 70;
theta0Seq    = linspace(-20, 5,  a);
% theta0Seq    = ones(1, a) * -14.2;
theta1Seq    = linspace(-5, 8, b);
% theta1Seq    = ones(1, b) * 2.1;
theta0SeqTem = repmat (theta0Seq, [b, 1]);
theta0SeqTem = reshape(theta0SeqTem, 1, []);
theta1SeqTem = repmat (theta1Seq, [1, a]);
ThetaSeq     = [theta0SeqTem; theta1SeqTem];

%%
X    = [ones(m, 1), x];
h    = sigmoid( X * ThetaSeq );
cost = (h - repmat(y, 1, a * b)) .^ 2 / 2;
jSeq = reshape(sum(cost) / m, [b, a])';

%%
figure('name', 'Visualize cost function');
mesh(theta1Seq, theta0Seq, jSeq);
xlabel('\theta_0');
ylabel('\theta_1');
zlabel('Cost function');
colorbar('location', 'northoutside');
view([-90, 0]);

%%
figure('name', 'Cost function contour')
contour(theta1Seq, theta0Seq, jSeq, 50);
xlabel('\theta_0');
ylabel('\theta_1');
% print('costcontour.png', '-dpng');
colorbar('location', 'eastoutside');
