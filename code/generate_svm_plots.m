%% Plots/submission for SVM portion, Question 1.

%% Put your written answers here.
clear all
answers{1} = 'Answer to 1.3';

save('problem_1_answers.mat', 'answers');

%% Load and process the data.

load ../data/windows_vs_mac.mat;
[X Y] = make_sparse(traindata, vocab);
[Xtest Ytest] = make_sparse(testdata, vocab);

%% Bar Plot - comparing error rates of different kernels

% INSTRUCTIONS: Use the KERNEL_LIBSVM function to evaluate each of the
% kernels you mentioned. Then run the line below to save the results to a
% .mat file.

k1 = @(x,x2) kernel_poly(x, x2, 1);
results.linear = kernel_libsvm(X, Y, Xtest, Ytest, k1);
k2 = @(x,x2) kernel_poly(x, x2, 2);
results.quadratic = kernel_libsvm(X, Y, Xtest, Ytest, k2);
k3 = @(x,x2) kernel_poly(x, x2, 3);
results.cubic =  kernel_libsvm(X, Y, Xtest, Ytest, k3);
k4 = @(x,x2) kernel_gaussian(x, x2, 20);
results.gaussian = kernel_libsvm(X, Y, Xtest, Ytest, k4);
k5 = @(x,x2) kernel_intersection(x, x2);
results.intersect = kernel_libsvm(X, Y, Xtest, Ytest, k5);

% Makes a bar chart showing the errors of the different algorithms.
algs = fieldnames(results);
for i = 1:numel(algs)
    y(i) = results.(algs{i});
end
bar(y);
set(gca,'XTickLabel', algs);
xlabel('Kernel');
ylabel('Test Error');
title('Kernel Comparisons');

print -djpeg -r72 plot_1.jpg;
