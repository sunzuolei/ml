clear ; close all; clc

load ('ex7data1.mat');
[X_norm, mu, sigma] = featureNormalize(X);
[U, S] = pca(X_norm);

plot(X_norm(:, 1), X_norm(:, 2), 'bo');
axis([-4 3 -4 3]); axis square

K = 1;
Z = projectData(X_norm, U, K);
X_rec  = recoverData(Z, U, K);

hold on;
plot(X_rec(:, 1), X_rec(:, 2), 'ro');
for i = 1:size(X_norm, 1)
    drawLine(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;

%=================================================================================
clear ; close all; clc
load ('ex7faces.mat');
displayData(X(1:100, :));
[X_norm, mu, sigma] = featureNormalize(X);
[U, S] = pca(X_norm);
displayData(U(:, 1:36)');
K = 100;
Z = projectData(X_norm, U, K);
X_rec  = recoverData(Z, U, K);

% Display normalized data
subplot(1, 2, 1);
displayData(X_norm(1:100,:));
title('Original faces');
axis square;

% Display reconstructed data from only k eigenfaces
subplot(1, 2, 2);
displayData(X_rec(1:100,:));
title('Recovered faces');
axis square;

fprintf('Program paused. Press enter to continue.\n');
pause;

