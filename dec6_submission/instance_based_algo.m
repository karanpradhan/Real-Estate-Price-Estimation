clear;
load ../data/city_train.mat
load ../data/city_test.mat
load ../data/word_train.mat
load ../data/word_test.mat
load ../data/bigram_train.mat
load ../data/bigram_test.mat
load ../data/price_train.mat

X_train =[city_train word_train bigram_train];
Y_train = price_train;
X_test = [city_test word_test bigram_test];

V = PCA([X_train;X_test],15);

fprintf('Reduced data set using SVD\n');
X_train = X_train*V;
X_test = X_test*V;

fprintf('Choosing the model\n');
X_train = X_train(1:1000,:);
Y_train = Y_train(1:1000,:);
%Found K=10  as the best K

N = size(X_test,1);
prices = zeros(N,1);

%predicting prices
for i = 1:size(X_test, 1)

prices(i) = kernreg(20,X_train,Y_train,X_test(i,:),'l2');

end

dlmwrite('submit_instance_based.txt',prices,'precision','%d');
