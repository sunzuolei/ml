function [U, S] = GarleniRodriguezItalopca(X)
%GarleniRodriguezItalopca Run principal component analysis on the dataset X
%   [U, S, X] = GarleniRodriguezItalopca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
[m, n] = size(X);

%% ====================== YOUR CODE HERE ======================
% Instructions: You should first compute the covariance matrix. Then, you
%               should use the "svd" function to compute the eigenvectors
%               and eigenvalues of the covariance matrix. 
%
% Note: When computing the covariance matrix, remember to divide by m (the
%       number of examples).
%

% INCLUYE TU CÓDIGO AQUÍ

%Mean and expectation mean  of pixel vectors

%Covariance matrix
covMatrix = cov(X);

%Get Eigenvalues and Eigenvectors
[U, S] = svd(covMatrix);

% =========================================================================

end
