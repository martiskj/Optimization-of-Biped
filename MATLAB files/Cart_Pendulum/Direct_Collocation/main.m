clc;
clear all;
close all;

%% Set parameters and initial guess
tic;
[M, mp, Lc, g, mu, Jp] = set_parameters();
parameters = [M, mp, Lc, g, mu, Jp];
N = 50;

guess.initialState = [0,0,0,0,0,0]';
guess.time = linspace(0, 2*pi, N);
[~, initial_guess] = ode45(@(t,x) dynamics(x, 0.1*cos(t), parameters), guess.time, guess.initialState);
initial_guess = initial_guess';
initial_guess = [initial_guess; 0.1*cos(guess.time)];
initial_guess = [initial_guess, [0;0;0;0;0;0;guess.time(end)]];
toc
%% Optimization
solution = optimization(initial_guess, parameters);
toc
%% Plot solutions
t = linspace(0, solution(end,end), N);
figure;
plot(t, solution(1:6,1:end-1));
xlabel('time');
ylabel('states')
title('Optimal trajectory theta')
legend('theta','dtheta','x','dx','y','dy');
%%
solution(6,end) = solution(end, end);
solution = solution(1:6,:);

animate_pendulum(solution)