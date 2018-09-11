clear all, close all, clc

k = [1:30]';
x = 2.^(-k);
f = @(x)(1 - cos(x))./(x.^2);
[k x f(x)]

f_taylor_4 = @(x)1/2 - x.^2/24 + x.^4/720;
[k x f(x) f_taylor_4(x)]