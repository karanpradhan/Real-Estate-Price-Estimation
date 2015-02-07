 function [beste , bestb, bestc, minError]  = searchLibLinear(X_train, Y_train)

epsilon = 2.^[-5:1:12];
bias = 2.^[3:0.25:6];
c = 2.^[-12:0.5:4];
beste = inf;
bestb = inf;
bestc = inf;
minError = inf;
for k = 1: numel(c)
    for i = 1:numel(bias)
        for j = 1:numel(epsilon)
            error = train(Y_train,X_train, sprintf('-s 11 -v 10 -q -c %g -p %g -B %g',c(k), epsilon(j), bias(i)));
            if minError > error
                beste = epsilon(j);
                bestb = bias(i);
                bestc = c(k);
                minError = error;
            end
        end
    end
end

end