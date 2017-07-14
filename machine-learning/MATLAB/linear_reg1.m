clear all
clc
load iris_dataset.mat;

%figure();
%gplotmatrix(irisInputs');
x = irisInputs(3,:);
t = irisInputs(4,:);

% normalize data
x = zscore(x);
t = zscore(t);
%figure();
%plot(x, t, 'bo');

fit_specifications = fittype({'1', 'x'}, 'independent', 'x', 'dependent', 't', 'coefficients', {'w0', 'w1'});
[fitresult, gof] = fit(x', t', fit_specifications);

ls_model = fitlm(x, t);

n_sample = length(x);
Phi = [ones(n_sample, 1) x'];
mpinv = pinv(Phi' * Phi) * Phi';
w = mpinv * t';