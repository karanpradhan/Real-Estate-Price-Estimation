clear;
addPathScript

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

V = PCA([X_train;X_test],20);

fprintf('Reduced data set using SVD\n');
X_train = X_train*V;
X_test = X_test*V;

%First model data
X_train_1 = X_train(1:5000,:);
Y_train_1 = Y_train(1:5000,:);

%Second model data
X_train_2 = X_train(5001:10000,:);
Y_train_2 = Y_train(5001:10000,:);

%Third model data
X_train_3 = X_train(10001:15000,:);
Y_train_3 = X_train(10001:15000,:);

%Fourth model data
X_train_4 = X_train(15001:end,:);
Y_train_4 = X_train(15001:end,:);

sigma = 2e-3;
rbfKernel = @(X,Y) exp(-sigma .* pdist2(X,Y,'euclidean'));

numTrain_1 = size(X_train_1,1);
numTrain_2 = size(X_train_2,1);
numTrain_3 = size(X_train_3,1);
numTrain_4 = size(X_train_4,1);

K_1= [ (1:numTrain_1)', rbfKernel(X_train_1,X_train_1)];
K_2= [ (1:numTrain_2)', rbfKernel(X_train_2,X_train_2)];
K_3= [ (1:numTrain_3)', rbfKernel(X_train_3,X_train_3)];
K_4= [ (1:numTrain_4)', rbfKernel(X_train_4,X_train_4)];
%K_test = [ (1:numTest)' , rbfKernel(X_test,X_train)];

fprintf('Applied Kernel Transformation\n');

%Xval for model 1
crange = 10.^[-10:2:3];
for i = 1:numel(crange)
    acc(i) = svmtrain(Y_train_1, K_1, sprintf('-h 0 -s 3 -t 4 -v 10 -c %g -q', crange(i)));
end
[~, bestc1] = min(acc);

%Xval for model 2
crange = 10.^[-10:2:3];
for i = 1:numel(crange)
    acc(i) = svmtrain(Y_train_2, K_2, sprintf('-h 0 -s 3 -t 4 -v 10 -c %g -q', crange(i)));
end
[~, bestc2] = min(acc);

%Xval for model 3
crange = 10.^[-10:2:3];
for i = 1:numel(crange)
    acc(i) = svmtrain(Y_train_3, K_3, sprintf('-h 0 -s 3 -t 4 -v 10 -c %g -q', crange(i)));
end
[~, bestc3] = min(acc);


%Xval for model 4
crange = 10.^[-10:2:3];
for i = 1:numel(crange)
    acc(i) = svmtrain(Y_train_4, K_4, sprintf('-h 0 -s 3 -t 4 -v 10 -c %g -q', crange(i)));
end
[~, bestc4] = min(acc);

%Creating models

model(1) = svmtrain(Y_train_1,K_1,sprintf('-h 0 -s 3 -t 4 -c %g',bestc1));
model(2) = svmtrain(Y_train_2,K_2,sprintf('-h 0 -s 3 -t 4 -c %g',bestc2));
model(3) = svmtrain(Y_train_3,K_3,sprintf('-h 0 -s 3 -t 4 -c %g',bestc3));
model(4) = svmtrain(Y_train_4,K_4,sprintf('-h 0 -s 3 -t 4 -c %g',bestc4));

%model = svmtrain(Y_train,K,sprintf('-h 0 -s 3 -t 4 -c %g',bestc));

%save('custom_svm.mat','model');
N = size(X_test,1);
prices = zeros(N,1);

%predicting prices
for i = 1:size(X_test, 1)
    
    K_test_1 = [1 rbfKernel(X_train_1,X_test(i,:))'];
    K_test_2 = [1 rbfKernel(X_train_2,X_test(i,:))'];
    K_test_3 = [1 rbfKernel(X_train_3,X_test(i,:))'];
    K_test_4 = [1 rbfKernel(X_train_4,X_test(i,:))'];


 
    val = svmpredict(0, K_test_1, model(1)) + svmpredict(0, K_test_2, model(2))+svmpredict(0, K_test_3, model(3)) + svmpredict(0, K_test_4, model(4));
    prices(i) = val/4 ;
    
end

dlmwrite('submit_custom_kernel.txt',prices,'precision','%d');
