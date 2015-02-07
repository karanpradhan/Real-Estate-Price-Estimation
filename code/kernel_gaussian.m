function K = kernel_gaussian(X, X2, sigma)
% Evaluates the Gaussian Kernel with specified sigma
%
% Usage:
%
%    K = KERNEL_GAUSSIAN(X, X2, SIGMA)
%
% For a N x D matrix X and a M x D matrix X2, computes a M x N kernel
% matrix K where K(i,j) = k(X(i,:), X2(j,:)) and k is the Guassian kernel
% with parameter sigma=20.

X = X';
X2 = X2';
n = size(X,2);
m = size(X2,2);
K = zeros(n, m);

for i=1:n
    for j=1:m
        K(i,j) = sum((X(:,i)-X2(:,j)).^2);
    end
end

 K= K'       
 K = exp(- K /(2*(sigma^2)));




% HINT: Transpose the sparse data matrix X, so that you can operate over columns. Sparse
% column operations in matlab are MUCH faster than row operations.

% YOUR CODE GOES HERE.
