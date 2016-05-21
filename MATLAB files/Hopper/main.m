clc;
clear all;
close all;

parameters = set_parameters();
N = 50;
guess.endTime = 4;
guess.stepTime = guess.endTime/(N-1);
guess.position = 1.8365*ones(1,N);%2*cos(0:guess.stepTime:guess.endTime)+2;
guess.velocity = [0, diff(guess.position)./guess.stepTime];

initial_guess = [guess.position; guess.velocity];
initial_guess = [initial_guess, [0; guess.endTime]];

%% Optimization
solution = optimization(initial_guess, parameters);
plot_solution(solution)

