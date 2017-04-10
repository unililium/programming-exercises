clear
clc
n_points = 1000;
eps = 0.7;
func = @(x)(1 + 1/2*x + 1/10*x.^2);
x = 5 * rand(n_points, 1);
t = func(x);
t_noisy = func(x) + eps * randn(n_points, 1);
phi = [x x.^2];
lin_model = fitlm(x, t_noisy);
qua_model = fitlm(phi, t_noisy);
real_par = [1 1/2 1/10];
best_lin_par = [7/12 1 0];
lin_c = [lin_model.Coefficients.Estimate' 0];
qua_c = qua_model.Coefficients.Estimate;
figure();
plot3(real_par(1),real_par(2),real_par(3),'bx');
hold on
grid on;
plot3(best_lin_par(1),best_lin_par(2),best_lin_par(3),'ro');
plot3(lin_c(1),lin_c(2),lin_c(3),'r+');
plot3(qua_c(1),qua_c(2),qua_c(3),'b+');
title('Parameter space');
xlabel('w_0');
ylabel('w_1');
zlabel('w_2');