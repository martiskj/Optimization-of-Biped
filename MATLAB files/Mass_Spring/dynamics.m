function x_dot = dynamics(x, parameters)
%% x_dot = f(x)
% Dynamics for the system
% This is to be used in the collocation constraints

%% Mass spring system
m = parameters(1); k = parameters(2); g = parameters(3);
x1 = x(1); %position
x2 = x(2); %velocity

x1_dot = x2;
x2_dot = -k/m*x1;

x_dot = [x1_dot, x2_dot]';