function [ V ] = PCA( X_train,k )
%PCA Summary of this function goes here
%   Detailed explanation goes here
%means = mean(X_train);
X_train_new = X_train;
%sd = std(X_train,1,1);
%X_train_new = bsxfun(@minus,X_train,means);
%X_train_new = bsxfun(@rdivide,X_train_new,sd);
 [~,~, V] = svds(X_train_new,k);
 %Z = X_train_new * V;
% [~,~,PC] = svds(X,k);
% mu = mean(X);
% Z = sparse(size(X,1),k);
% for i=1:size(X,1)
%     Z(i,:) = (mu-X(i,:))*PC;
% end
end

