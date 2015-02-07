clear;
load ../data/city_train.mat
load ../data/city_test.mat
load ../data/word_train.mat
load ../data/word_test.mat
load ../data/bigram_train.mat
load ../data/bigram_test.mat
load ../data/price_train.mat

X_train =[city_train word_train bigram_train ];
Y_train = price_train;
X_test = [city_test word_test bigram_test];

initialize_additional_features;

%% Run algorithm
% Example by lazy TAs


N = size(X_test,1);
prices = zeros(N,1);

crange = 10.^[-10:2:3];

% for i = 1:numel(crange)
%    acc(i) = train(Y_train,X_train, sprintf('-s 11 -v 10 -q -c %g', crange(i)));
% end
%[~, bestc] = min(acc);
% epsilon = 10.^[-4:1:1];
% for i = 1:numel(epsilon)
%     acc(i) = train(Y_train,X_train, sprintf('-s 11 -v 10 -q -c 1 -p %g', epsilon(i)));
% end

%MSE 0.63 with below code RMSE on leader 0.7596
%model = train(Y_train, X_train, sprintf('-s 11 -c 1 -v 10 -q -p 0.001 -B 1'));
%prices = predict(prices,X_test,model);

cv = cvpartition(size(X_train,1),'KFold',10);
[w fitinfo] = lasso(X_train,Y_train,'CV',cv);

%% Save results to a text file for submission
dlmwrite('submit.txt',prices,'precision','%d');