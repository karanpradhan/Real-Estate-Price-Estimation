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
inputs = X_train';
targets = Y_train';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);

net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
%net.trainFcn = 'trainbr';
fprintf('\nTraining.....');
[net,tr] = train(net,inputs,targets);
fprintf('\nCompleted..');
