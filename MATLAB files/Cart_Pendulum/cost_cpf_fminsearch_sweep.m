function [cost_tot,c1,c2,c3,c4] = cost_cpf_fminsearch_sweep(params_theta,speed_des, cost_weights)

%% Define constraints, via output vectors c and ceq.
%   c <= 0
%   ceq = 0
% Above are the required constraints

speed_weight = cost_weights(1);
Fy_weight = cost_weights(2);
tau_weight = cost_weights(3);

if ~exist('speed_des','var') || isempty(speed_des)
    speed_des = -.05; 
end


[cost_val, tu, taup, theta, dtheta, d2theta, xu, Fy, COT, speed] = ...
    cost_cpf(params_theta,[],[],speed_des);

tau_max = 100;

c_Fy_strictly_pos = -(min(Fy)); % Fy >=0, so this <=0
c_tau_max_limit = max(abs(taup)) - tau_max;  % taup <= tau_max

c1 = COT; % want to minimize cost of transport;
c2 = speed_weight*(speed-speed_des)^2; % and get "close" to target speed
c3 = Fy_weight*(min(Fy)<0) * (min(Fy)^2); % quadratic penalty when Fy gets negative
c4 = tau_weight*(max(abs(taup))>tau_max) * (max(abs(taup))-tau_max)^2; % quadratic penalty when tau gets too large

cost_tot = c1 + c2 + c3 + c4;
if 0 %(c3+c4)>0
    [cost_tot c1 c2 c3 c4]
end

