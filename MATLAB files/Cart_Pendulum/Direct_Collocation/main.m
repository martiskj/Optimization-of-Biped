clc;
clear all;
close all;
addpath(genpath(strcat(pwd, '/friction_models/')));

%% Initial guess for trajectory
[M, mp, Lc, g, mu, Jp] = set_parameters();
parameters = [M, mp, Lc, g, mu, Jp];
N = 50;

guess.initialState = [0,0,0,0,0,0]';
guess.time = linspace(0, 2*pi, N);
[~, guess.initialTrajectories] = ode45(@(t,x) dynamics(x, 0.1*cos(t), parameters), guess.time, guess.initialState);
guess.initialTrajectories = guess.initialTrajectories';
guess.initialTrajectories = [guess.initialTrajectories; 0.1*cos(guess.time)];
guess.initialTrajectories = [guess.initialTrajectories, [0;0;0;0;0;0;guess.time(end)]];

%% Optimization
solution = optimization(guess.initialTrajectories, parameters);
animate_pendulum(solution)