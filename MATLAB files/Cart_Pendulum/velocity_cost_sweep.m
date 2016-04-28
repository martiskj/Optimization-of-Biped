clc;
clear all;

Fy_weight = 1e5;
tau_weight = 1e5;
speed_weight_list = [1e2, 1e4, 1e6, 1e8, 1e10];
speed_des = 0.07;
parameters_init = [ -5.1110  -14.0827   -5.5163   -4.3166    0.9757   -0.8109    0.6758 1];
parameter_list = zeros(length(speed_weight_list), 8);
speed_list = zeros(length(speed_weight_list),1);

for weight = 1:length(speed_weight_list)
    weight
	cost_weights = [speed_weight_list(weight), Fy_weight, tau_weight];
	parameter_list(weight,:)  = optimize_with_cost_sweep(speed_des, parameters_init, cost_weights, 'fminsearch');
	[~, ~, ~, ~, ~, ~, ~, ~, ~, speed_list(weight)] = cost_cpf(parameter_list(weight,:), 0, 1, speed_des);
end
%%
% save('data/velocity_weight_sweep/deviation_from_des_speed.mat','cost_weights','parameter_list','speed_list');

%% Plot
figure;
loglog(speed_weight_list, abs(speed_list(:,1) - speed_des), ':bo','MarkerFaceColor','b');
title(sprintf('Desired speed = %.3f', speed_des));
ylabel('Deviation from desired speed');
xlabel('Speed cost weight');
grid on;

