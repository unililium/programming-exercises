load iris_dataset.mat;
x = zscore(irisInputs([1 2], :)');
t = irisTargets(1,:)';
gplotmatrix(x, [], t);

net = perceptron;
net = train(net, x', t');

figure();
gscatter(x(:,1),x(:,2),perc_t);
hold on;
s = -2:0.01:2.5;
plot(s, -(s * net.IW{1}(1) + net.b{1} ) / net.IW{1}(2), 'k');
plot(s, -(s * w(2) + w(1)) / w(3), 'r');