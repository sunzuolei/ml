%% Initialization

clear ; close all; clc
%% ================== Section 1: Load Example Dataset  ===================
%  We start this exercise by using a small dataset that is easily to
%  visualize
%
load ('data1.mat');

%% =============== Section 2: Principal Component Analysis ===============
%  You should now implement PCA, a dimension reduction technique.

%  Before running PCA, it is important to first normalize X
[X_norm, mu, sigma] = featureNormalize(X);
% Run PCA SVD 
[U, S] = pca(X_norm);

%% =================== Section 3: Dimension Reduction ===================
%  You should now implement the projection step to map the data onto the 
%  first k eigenvectors. The code will then plot the data in this reduced 
%  dimensional space.  This will show you what the data looks like when 
%  using only the corresponding eigenvectors to reconstruct it.

%  Plot the normalized dataset (returned from pca)
plot(X_norm(:, 1), X_norm(:, 2), 'bo');
axis([-4 3 -4 3]); axis square

%  Project the data onto K = 1 dimension
K = 1;
Z = projectData(X_norm, U, K);
X_rec  = recoverData(Z, U, K);

%  Draw lines connecting the projected points to the original points
hold on;
plot(X_rec(:, 1), X_rec(:, 2), 'ro');
for i = 1:size(X_norm, 1)
    drawLine(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
hold off






