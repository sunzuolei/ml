%% =============Section1  Initialization================================
clear ; close all; clc
path(path, genpath('../p60'));
%% =============Section2 Loading and Visualizing Face Data =============
%  We start the exercise by first loading and visualizing the dataset.
%  Load Face dataset
load ('faces.mat');
%  Display the first 100 faces in the dataset
displayData(X(1:100, :));

%% =========== Section 3: PCA on Face Data: Eigenfaces  ================
%  Run PCA and visualize the eigenvectors which are in this case eigenfaces
%  We display the first 36 eigenfaces.

%  Before running PCA, it is important to first normalize X by subtracting 
%  the mean value from each feature
[X_norm, mu, sigma] = featureNormalize(X);
[U, S] = pca(X_norm);
displayData(U(:, 1:36)');

%% ============= Section 4: Dimension Reduction for Faces ===============
%  Project images to the eigen space using the top k eigenvectors 
K = 100;
Z = projectData(X_norm, U, K);

%% ==== Section 5: Visualization of Faces after PCA Dimension Reduction ==
%  Project images to the eigen space using the top K eigen vectors and 
%  visualize only using those K dimensions
%  Compare to the original input, which is also displayed
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