clc;
clear all;
close all;

parameters = set_parameters();
N = 50;
guess.endTime = 3;
guess.stepTime = guess.endTime/(N-1);
guess.positions = 1.8365*ones(1,N);
guess.velocities = [0, diff(guess.positions)./guess.stepTime];

guess.initialTrajectories = [guess.positions; guess.velocities];
guess.initialTrajectories = [guess.initialTrajectories, [0; guess.endTime]];

%% Optimization
solution = optimization(guess.initialTrajectories, parameters);
plot_solution(solution)