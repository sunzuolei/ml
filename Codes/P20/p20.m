clear all; close all; clc;

path(path, '../P11');
path(path, '../Data');
path(path, '../P18');

load dataChap4.mat

%%
x    = data(:, 1);
y    = data(:, 2);
m    = length(y);

%%
a            = 150;
b            = 160;
theta0Seq    = linspace(-33, 40,  a);
theta1Seq    = linspace(-11, 20, b);
theta0SeqTem = repmat (theta0Seq, [b, 1]);
theta0SeqTem = reshape(theta0SeqTem, 1, []);
theta1SeqTem = repmat (theta1Seq, [1, a]);
ThetaSeq     = [theta0SeqTem; theta1SeqTem];

%%
X       = [ones(m, 1), x];
ySeq    = repmat(y, 1, a*b);
jSeqTem = computeCostLog(X, ySeq, ThetaSeq);
jSeq    = reshape(jSeqTem, [b, a])';

%%
figure('name', 'Visualize cost function');
mesh(theta1Seq, theta0Seq, jSeq);
xlabel('\theta_1');
ylabel('\theta_0');
zlabel('Cost');
colorbar('location', 'westoutside');
box on
view([32, 44]);

%%
figure('name', 'Cost function contour')
contour(theta1Seq, theta0Seq, jSeq, 50);
xlabel('\theta_1');
ylabel('\theta_0');
% print('costcontour.png', '-dpng');
colorbar('location', 'eastoutside');
