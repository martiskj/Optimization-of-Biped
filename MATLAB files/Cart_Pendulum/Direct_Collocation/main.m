clc;
clear all;
close all;

%% Set parameters and initial guess
[M, mp, Lc, g, mu, Jp] = set_parameters();

% Need to include the timespan in the optimization problem
T_max = 2;
N = 50;
h_k = T_max/(N-1);
t = (0:h_k:T_max);
parameters = [M, mp, Lc, g, Jp, h_k];

% x = [theta; dtheta; x; dx; y; dy]
% AND need to include T_max at the end

%Initial guess
theta = sin(6*t);
dtheta = [0, diff(theta)];
x = linspace(0, 1, N);
dx = [0 diff(x)];
y = zeros(1,N);
dy = zeros(1,N);
taup = ones(1,N); %Better sugetsion for a guess?

initial_guess = [theta; dtheta; x; dx; y; dy; taup];


%% Optimization
solution = optimization(initial_guess, parameters);

%% Plot solutions
figure;
subplot(2,1,1);
plot(t, solution(1,:));
xlabel('time');
ylabel('theta')
title('Optimal trajectory theta')

subplot(2,1,2)
plot(t, solution(3,:));
xlabel('time');
ylabel('position cart')
title('Position cart')
% 


% animate_pendulum(t, solution(3,:), solution(1,:))