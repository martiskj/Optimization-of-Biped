clc;
clear all;
close all;

parameters = set_parameters;
tMax = 5;
tspan = [0 tMax];
guess.position = 1.8365;
guess.velocity = 0;

%% Optimization
x_lb = [0; 0];
x_ub = [inf; 0];
optionsFMINCON = optimoptions(@fmincon, 'Algorithm', 'interior-point', 'Display', 'iter','maxFunEvals', 1e5);
optimal_solution = fmincon(@(x) objective_function(x, tspan, parameters), [guess.position; guess.velocity], [],[],[],[],x_lb, x_ub, [], optionsFMINCON);
plot_solution(optimal_solution, tspan, parameters)