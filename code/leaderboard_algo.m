clear
addPathScript
seperate_city
load ./city_seperated_data.mat
%load X_train , Y_train, X_test

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


[beste1 , bestb1, bestc1, minError1] = searchLibLinear(X_train_1, Y_train_1);
[beste2 , bestb2, bestc2, minError2] = searchLibLinear(X_train_2, Y_train_2);
[beste3 , bestb3, bestc3, minError3] = searchLibLinear(X_train_3, Y_train_3);
[beste4 , bestb4, bestc4, minError4] = searchLibLinear(X_train_4, Y_train_4);
[beste5 , bestb5, bestc5, minError5] = searchLibLinear(X_train_5, Y_train_5);
[beste6 , bestb6, bestc6, minError6] = searchLibLinear(X_train_6, Y_train_6);
[beste7 , bestb7, bestc7, minError7] = searchLibLinear(X_train_7, Y_train_7);

model(1) = train(Y_train_1, X_train_1, sprintf('-s 11 -c %g -q -p %g -B %g',bestc1, beste1, bestb1));
model(2) = train(Y_train_2, X_train_2, sprintf('-s 11 -c %g -q -p %g -B %g',bestc2, beste2, bestb2));
model(3) = train(Y_train_3, X_train_3, sprintf('-s 11 -c %g -q -p %g -B %g',bestc3, beste3, bestb3));
model(4) = train(Y_train_4, X_train_4, sprintf('-s 11 -c %g -q -p %g -B %g',bestc4, beste4, bestb4));
model(5) = train(Y_train_5, X_train_5, sprintf('-s 11 -c %g -q -p %g -B %g',bestc5, beste5, bestb5));
model(6) = train(Y_train_6, X_train_6, sprintf('-s 11 -c %g -q -p %g -B %g',bestc6, beste6, bestb6));
model(7) = train(Y_train_7, X_train_7, sprintf('-s 11 -c %g -q -p %g -B %g',bestc7, beste7, bestb7));

N = size(X_test,1);
prices = zeros(N,1);

for i=1:size(X_test,1)
    testing_row = X_test(i,:);
    model_num = find(testing_row(1:7),1);
    prices(i) = predict(0, testing_row(8:end), model(model_num));
end


dlmwrite('submit.txt',prices,'precision','%d');
