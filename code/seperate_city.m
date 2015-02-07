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

X_train_1 = X_train(X_train(:,1) == 1,:);
Y_train_1 = Y_train(X_train(:,1) == 1,:);

X_train_2 = X_train(X_train(:,2) == 1,:);
Y_train_2 = Y_train(X_train(:,2) == 1,:);

X_train_3 = X_train(X_train(:,3) == 1,:);
Y_train_3 = Y_train(X_train(:,3) == 1,:);

X_train_4 = X_train(X_train(:,4) == 1,:);
Y_train_4 = Y_train(X_train(:,4) == 1,:);

X_train_5 = X_train(X_train(:,5) == 1,:);
Y_train_5 = Y_train(X_train(:,5) == 1,:);

X_train_6 = X_train(X_train(:,6) == 1,:);
Y_train_6 = Y_train(X_train(:,6) == 1,:);

X_train_7 = X_train(X_train(:,7) == 1,:);
Y_train_7 = Y_train(X_train(:,7) == 1,:);

X_train_1 = X_train_1(:,8:end);
X_train_2 = X_train_2(:,8:end);
X_train_3 = X_train_3(:,8:end);
X_train_4 = X_train_4(:,8:end);
X_train_5 = X_train_5(:,8:end);
X_train_6 = X_train_6(:,8:end);
X_train_7 = X_train_7(:,8:end);


save('city_seperated_data.mat','X_train_1','X_train_2','X_train_3','X_train_4','X_train_5','X_train_6','X_train_7','Y_train_1','Y_train_2','Y_train_3','Y_train_4','Y_train_5','Y_train_6','Y_train_7');

