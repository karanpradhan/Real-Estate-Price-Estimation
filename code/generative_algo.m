clear
addPathScript 
seperate_city
load ./city_seperated_data.mat

X_train_rename = X_train_4;
[~,~,V] = svds(X_train_rename,1);
X = X_train_rename*V;
obj = fitgmdist(X,2);
idx = cluster(obj,X);
X_train_4_1 = X_train_4(idx == 1,:);
X_train_4_2 = X_train_4(idx == 2,:);

Y_train_4_1 = Y_train_4(idx == 1,:);
Y_train_4_2 = Y_train_4(idx == 2,:);

N = size(X_test,1);
prices = zeros(N,1);

%Cross validate

[beste1 , bestb1, bestc1, minError1]  = searchLibLinear(X_train_1, Y_train_1);
[beste2 , bestb2, bestc2, minError2]  = searchLibLinear(X_train_2, Y_train_2);
[beste3 , bestb3, bestc3, minError3]  = searchLibLinear(X_train_3, Y_train_3);
[beste4_1 , bestb4_1, bestc4_1, minError4_1]  = searchLibLinear(X_train_4_1, Y_train_4_1);
[beste4_2 , bestb4_2, bestc4_2, minError4_2]  = searchLibLinear(X_train_4_2, Y_train_4_2);
[beste5 , bestb5, bestc5, minError5]  = searchLibLinear(X_train_5, Y_train_5);
[beste6 , bestb6, bestc6, minError6]  = searchLibLinear(X_train_6, Y_train_6);
[beste7 , bestb7, bestc7, minError7]  = searchLibLinear(X_train_7, Y_train_7);


%Crossvalidation done!

model(1) = train(Y_train_1, X_train_1, sprintf('-s 11 -c %g -q -p %g -B %g',bestc1, beste1, bestb1));
model(2) = train(Y_train_2, X_train_2, sprintf('-s 11 -c %g -q -p %g -B %g',bestc2, beste2, bestb2));
model(3) = train(Y_train_3, X_train_3, sprintf('-s 11 -c %g -q -p %g -B %g',bestc3, beste3, bestb3));
model4_1 = train(Y_train_4_1, X_train_4_1, sprintf('-s 11 -c %g -q -p %g -B %g',bestc4_1, beste4_1, bestb4_1));
model4_2 = train(Y_train_4_2, X_train_4_2, sprintf('-s 11 -c %g -q -p %g -B %g',bestc4_2, beste4_2, bestb4_2));
model(5) = train(Y_train_5, X_train_5, sprintf('-s 11 -c %g -q -p %g -B %g',bestc5, beste5, bestb5));
model(6) = train(Y_train_6, X_train_6, sprintf('-s 11 -c %g -q -p %g -B %g',bestc6, beste6, bestb6));
model(7) = train(Y_train_7, X_train_7, sprintf('-s 11 -c %g -q -p %g -B %g',bestc7, beste7, bestb7));



for i = 1:size(X_test, 1)
    testing_row = X_test(i,:);
    model_num = find(testing_row(1:7),1);
    if (model_num == 4)
       [ ~, ~, V] = svds(testing_row,1);
       testing_row_pca = testing_row * V;
       idx = cluster(obj, testing_row_pca);
       if idx == 1
           prices(i) = predict(0, testing_row(8:end), model4_1);
       else
           prices(i) = predict(0, testing_row(8:end), model4_2);
       end
    else
        prices(i) = predict(0, testing_row(8:end), model(model_num));
    end
    
    
end
    


%% Save results to a text file for submission
dlmwrite('submit_generative.txt',prices,'precision','%d');

