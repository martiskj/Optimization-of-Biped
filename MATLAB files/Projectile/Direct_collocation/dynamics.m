function x_dot = dynamics(x, t, dx0, dy0, parameters)
%% x_dot = f(x,t)
% Dynamics for the system
% This is to be used in the collocation constraints

%% Projectile system
m = parameters(1); g = parameters(2);

x1_dot = dx0;
x2_dot = 0;
x3_dot = dy0 - g*t;
x4_dot = -g;

x_dot = [x1_dot, x2_dot, x3_dot, x4_dot]';