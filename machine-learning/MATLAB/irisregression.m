load iris_dataset.mat;

x = irisInputs(3,:);
t = irisInputs(4,:);
x = zscore(x);
t = zscore(t);
figure();
plot(x,t,'bo');