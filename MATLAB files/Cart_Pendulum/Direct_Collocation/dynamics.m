function x_dot = dynamics(x, parameters)
%% x_dot = f(x)
% Dynamics for the system
% This is to be used in the collocation constraints

%% Cart-pendulum system
M = parameters(1); mp = parameters(2); Lc = parameters(3); g = parameters(4); mu = parameters(5); Jp = parameters(6)
x1 = x(1); % Angle of pendulum
x2 = x(2); % Angular velocity of panedulum

% INSERT EOM


x_dot = 