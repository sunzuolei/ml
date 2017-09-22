clear ; close all; clc

load('data1.mat');

plot(X(:, 1), X(:, 2), 'bx');
axis([0 30 0 30]);
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');

[mu sigma2] = estimateGaussian(X);
p = multivariateGaussian(X, mu, sigma2);

visualizeFit(X,  mu, sigma2);
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');

pval = multivariateGaussian(Xval, mu, sigma2);
[epsilon F1] = selectThreshold(yval, pval);

outliers = find(p < epsilon);

hold on
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off

fprintf('Program paused. Press enter to continue.\n');