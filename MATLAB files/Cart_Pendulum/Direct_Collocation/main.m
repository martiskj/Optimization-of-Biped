clc;
clear all;
close all;

%% Set parameters and initial guess
[M, mp, Lc, g, mu, Jp] = set_parameters();

% Need to include the timespan in the optimization problem
T_max = 15;
N = 50;
h_k = T_max/(N-1);
t = (0:h_k:T_max);
parameters = [M, mp, Lc, g, Jp];

% Include "everything" in x:
% x = [theta; theta_dot; cart_pos; cart_pos_dot]
% AND need to include T_max at the end


%% Optimization
solution = optimization(initial_guess, parameters);

%% Plot solutions
figure;
subplot(2,1,1);
plot(t, solution(1,:));
xlabel('time');
ylabel('position')
title('Optimal trajectory position')

subplot(2,1,2)
plot(t, solution(2,:));
xlabel('time');
ylabel('velocity')
title('Optimal trajectory velocity')



