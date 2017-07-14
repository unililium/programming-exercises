function [ W, b ] = perceptron( X, Y, max_i )
    W = ones(1,length(X));
    b = 0;
    for i = 1:max_i
        for x = X y = Y;
            a = sum(W*X) + b;
            if y*a <= 0
                W = W + Y * X;
                b = b + y;
            end
        end
    end
end