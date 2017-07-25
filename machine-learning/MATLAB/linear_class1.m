clc
clear
load iris_dataset.mat;
x = zscore(irisInputs([1 2], :)');
t = irisTargets(1,:)';
gplotmatrix(x, [], t);

net = perceptron;
net = train(net, x', t');