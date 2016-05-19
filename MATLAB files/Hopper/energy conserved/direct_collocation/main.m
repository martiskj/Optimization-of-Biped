clc;
clear all;
close all;

%% Set parameters
m = 1;
k = 60;
xs = 2;
g = 9.81;
tMax = 5; 

%% Find the "exact" solution by simulation
parameters = [m, k, xs, g, tMax];
tspan = [0 tMax];
x_init = [4;0];
[tsim, exact_solution] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);

%% Find the optimal solution with direct collocation
N = 100;
tMax = 5;
x_init = [4; 0];
[initial_guess, time] = calc_init_trajectory(x_init, N, tMax, parameters);

figure;
hold on;
plot(time, initial_guess);
%plot(tsim, solution(:,3));
title('Initial guess')
hold off;
grid on;

optimal_solution = optimization(initial_guess, parameters);

%% Plot
figure;
hold on;
plot(tsim, exact_solution);
%plot(tsim, solution(:,3));
title('"Exact", simulated solution')
hold off;
grid on;

figure;
hold on;
plot(time, optimal_solution);
%plot(tsim, solution(:,3));
title('Optimal solution by direct collocation')
hold off;
grid on;