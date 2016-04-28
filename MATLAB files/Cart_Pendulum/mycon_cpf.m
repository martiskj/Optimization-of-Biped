function [c,ceq] = mycon_cpf(params_theta,speed_des)

%% Define constraints, via output vectors c and ceq.
%   c <= 0
%   ceq = 0
% Above are the required constraints

if ~exist('speed_des','var') || isempty(speed_des)
    speed_des = -.05;
end

del_speed = .001;

[cost_val, tu, taup, theta, dtheta, d2theta, xu, Fy, COT, speed] = ...
    cost_cpf(params_theta,[],[],speed_des);

tau_max = 100;

c_Fy_strictly_pos = -(min(Fy)); % Fy >=0, so this <=0
c_tau_max_limit = max(abs(taup)) - tau_max;  % taup <= tau_max
%c_del_speed = -del_speed^2 + (speed - speed_des)^2;
%c_theta_off = abs(params_theta(1))-1.1*pi;


c = [c_Fy_strictly_pos
    c_tau_max_limit];
%    c_del_speed];
%    c_theta_off]


ceq = []; % no strict equalities here... could switch c and ceq, though


