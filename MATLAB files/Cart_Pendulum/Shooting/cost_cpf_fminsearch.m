function [cost_tot,c1,c2,c3,c4] = cost_cpf_fminsearch(params_theta,speed_des)

%% Define constraints, via output vectors c and ceq.
%   c <= 0
%   ceq = 0
% Above are the required constraints

if ~exist('speed_des','var') || isempty(speed_des)
    speed_des = -.05; 
end

%del_speed = .001;

[cost_val, tu, taup, theta, dtheta, d2theta, xu, Fy, COT, speed] = ...
    cost_cpf(params_theta,[],[],speed_des);

tau_max = 100;

c_Fy_strictly_pos = -(min(Fy)); % Fy >=0, so this <=0
c_tau_max_limit = max(abs(taup)) - tau_max;  % taup <= tau_max

c1 = COT; % want to minimize cost of transport;
c2 = 1e6*(speed-speed_des)^2; % and get "close" to target speed (Martin: originally 1e8)
c3 = 1e5*(min(Fy)<0) * (min(Fy)^2); % quadratic penalty when Fy gets negative
c4 = 1e5*(max(abs(taup))>tau_max) * (max(abs(taup))-tau_max)^2; % quadratic penalty when tau gets too large

cost_tot = c1 + c2 + c3 + c4;
if 0 %(c3+c4)>0
    [cost_tot c1 c2 c3 c4]
end

