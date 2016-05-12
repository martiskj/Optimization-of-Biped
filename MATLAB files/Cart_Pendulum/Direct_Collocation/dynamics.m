function x_dot = dynamics(x, u, parameters)
%% x_dot = f(x,u)
% Dynamics for the system
% This is to be used in the collocation constr?aints

%% Cart-pendulum system
M = parameters(1); mp = parameters(2); Lc = parameters(3); g = parameters(4); mu = parameters(5); Jp = parameters(6);
x1 = x(1); % theta
x2 = x(2); % dtheta
x3 = x(3); % x
x4 = x(4); % dx
x5 = x(5); % y
x6 = x(6); % dy
u = x(7); % taup

x1_dot = x2;
x2_dot = (taup*(M + mp))/(M*mp*Lc^2 + Jp*mp + Jp*M);
x3_dot = x4;
x4_dot = -(Lc*mp*(Jp*M*x2^2*sin(x1) - M*taup*cos(x1) - mp*taup*cos(x1) + Jp*x2^2*mp*sin(x1) + Lc^2*M*x2^2*mp*sin(x1)))/((M + mp)*(M*mp*Lc^2 + Jp*mp + Jp*M));
x5_dot = x6;
x6_dot = -(- cos(x1)*Lc^3*M*x2^2*mp^2 + g*Lc^2*M^2*mp + g*Lc^2*M*mp^2 - Jp*cos(x1)*Lc*M*x2^2*mp - taup*sin(x1)*Lc*M*mp - Jp*cos(x1)*Lc*x2^2*mp^2 - taup*sin(x1)*Lc*mp^2 + Jp*g*M^2 + 2*Jp*g*M*mp + Jp*g*mp^2)/((M + mp)*(M*mp*Lc^2 + Jp*mp + Jp*M));


x_dot = [x1_dot; x2_dot; x3_dot; x4_dot; x5_dot; x6_dot;];
