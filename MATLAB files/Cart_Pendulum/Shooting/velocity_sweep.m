%% Velocity Sweep

clc;
clear all;

speed_list = linspace(0.005,0.15,10);
number_of_initpoints = 10;
parameter_list = zeros(length(speed_list), number_of_initpoints, 8);

h = waitbar(0, 'Optimizing...');
time = tic;
for speed = 1:length(speed_list)
    for init_parameters = 1:number_of_initpoints
        parameters_init = [ -6.1110  -14.0827   -5.5163   -2.3166    0.9757   -0.8109    0.6758 1];
        parameters_init = 1*(rand(1,8)-.5) + parameters_init;
        optimal_parameters = optimize(speed_list(speed), parameters_init, 'fminsearch');
        parameter_list(speed, init_parameters, :) = optimal_parameters;
        waitbar(((speed - 1) * number_of_initpoints + init_parameters) / (length(speed_list) * number_of_initpoints));
    end
end
close(h)
toc(time)

%% Costcalculation
cost_list = zeros(length(speed_list),number_of_initpoints);
for speed = 1:length(speed_list)
    for init_parameters = 1:number_of_initpoints
        cost_list(speed,init_parameters) = cost_cpf_fminsearch(squeeze(parameter_list(speed,init_parameters,:))', speed_list(speed));
    end
end

save('data/velocity_sweep/sweep_copy2.mat','parameter_list','cost_list','speed_list');
%% Printfunction
% "Scatter":
figure;
subplot_width = 3;
subplot_height = ceil(length(speed_list)/3);
[number_of_speeds, number_of_initpoints] = size(cost_list);
title('Optimal Cost vs. Random Parameter Inputs')
for speed = 1:number_of_speeds
    subplot(subplot_height, subplot_width, speed);
    hold on;
    grid on;
    for init_parameters = 1:number_of_initpoints
        plot(init_parameters, cost_list(speed, init_parameters), ':bo', 'MarkerFaceColor','b');
    end
    hold off;
    title(sprintf('Speed = %.3f', speed_list(speed)));
    xlabel('#Init Parameter');
    ylabel('Cost');
end


% "Minimum cost vs. speeds":
figure;
hold on;
grid on;
for speed = 1:number_of_speeds
    minimum_cost = min(cost_list(speed,:));
    plot(speed_list(speed), minimum_cost, ':bo', 'MarkerFaceColor','b');
end
xlabel('Desired speed');
ylabel('Minimum Cost');
title('Minimum Cost vs. Desired Speed');