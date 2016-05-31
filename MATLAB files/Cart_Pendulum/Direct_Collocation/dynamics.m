function x_dot = dynamics(x, u, parameters)
%% x_dot = f(x,u)
% Dynamics for the system
% This is to be used in the collocation constraints

%% Cart-pendulum system
M = parameters(1); mp = parameters(2); Lc = parameters(3); g = parameters(4); mu = parameters(5); Jp = parameters(6);
theta   = x(1); 
dtheta  = x(2);
x       = x(3);
dx      = x(4);
y       = x(5); 
dy      = x(6);
taup    = u;
    

x1_dot = x2;
x2_dot = (M*u + mp*u)/(M*mp*Lc^2 + Jp*mp + Jp*M); %+ Lc*F_friction*mp*cos(theta)/(M*mp*Lc^2 + Jp*mp + Jp*M);

F_y = Lc*mp*cos(theta)*dtheta^2 - M*g - g*mp + Lc*x2_dot*mp*sin(theta);
if (dx > 1e-6)
    F_friction = mu*F_y;
else
    F_friction = min(Lc*mp*sin(theta)*dtheta^2 - Lc*x2_dot*mp*cos(theta), mu*F_y); %+ d2x*(M + mp);
end

x3_dot = x4;
x4_dot = (Jp*M*F_friction + Jp*F_friction*mp + Lc^2*M*F_friction*mp + Lc^2*F_friction*mp^2*cos(theta)^2 + Lc*mp^2*u*cos(theta) - Jp*Lc*dtheta^2*mp^2*sin(theta) + Lc*M*mp*u*cos(theta) - Lc^3*M*dtheta^2*mp^2*sin(theta) - Jp*Lc*M*dtheta^2*mp*sin(theta))/((M + mp)*(M*mp*Lc^2 + Jp*mp + Jp*M));
x5_dot = x6;
x6_dot = (cos(theta)*Lc^3*M*dtheta^2*mp^2 - g*Lc^2*M^2*mp - g*Lc^2*M*mp^2 + (F_friction*sin(2*theta)*Lc^2*mp^2)/2 + Jp*cos(theta)*Lc*M*dtheta^2*mp + u*sin(theta)*Lc*M*mp + Jp*cos(theta)*Lc*dtheta^2*mp^2 + u*sin(theta)*Lc*mp^2 - Jp*g*M^2 - 2*Jp*g*M*mp - Jp*g*mp^2)/((M + mp)*(M*mp*Lc^2 + Jp*mp + Jp*M));

x_dot = [x1_dot; x2_dot; x3_dot; x4_dot; x5_dot; x6_dot;];


