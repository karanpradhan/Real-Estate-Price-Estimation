clear;
load ./city_seperated_data.mat
fprintf('\n City1');
c = cvpartition(size(X_train_1,1),'KFold',10);
[B1 fitinfo1] = lasso(X_train_1,Y_train_1,'CV',c);

fprintf('\n City2');
c = cvpartition(size(X_train_2,1),'KFold',10);
[B2 fitinfo2] = lasso(X_train_2,Y_train_2,'CV',c);

fprintf('\n City3');
c = cvpartition(size(X_train_3,1),'KFold',10);
[B3 fitinfo3] = lasso(X_train_3,Y_train_3,'CV',c);

fprintf('\n City4');
c = cvpartition(size(X_train_4,1),'KFold',10);
[B4 fitinfo4] = lasso(X_train_4,Y_train_4,'CV',c);

fprintf('\n City5');
c = cvpartition(size(X_train_5,1),'KFold',10);
[B5 fitinfo5] = lasso(X_train_5,Y_train_5,'CV',c);

fprintf('\n City6');
c = cvpartition(size(X_train_6,1),'KFold',10);
[B6 fitinfo6] = lasso(X_train_6,Y_train_6,'CV',c);

fprintf('\n City7');
c = cvpartition(size(X_train_7,1),'KFold',10);
[B7 fitinfo7] = lasso(X_train_7,Y_train_7,'CV',c);

save 'lasso_objects_seperate_city_data.mat';