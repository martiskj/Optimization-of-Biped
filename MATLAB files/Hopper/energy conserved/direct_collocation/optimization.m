function solution = optimization(x_init, parameters)

%% Optimization by direct collocation
% Uses trapezoid method (assumes dynamics are linear between grid points)
% Possible to try a more sophisticated approach


%% Try to find the highest possible altitude for a lossless mass-spring jumper
% Path constraints (no constraints on velocity)
x_lb = zeros(2,length(x_init));
x_lb(1,:) = 0;
x_lb(2,:) = -inf;
% x_lb(end,end) = 0;
x_ub = zeros(2,length(x_init));
x_ub(1,:) = 4;
x_ub(2,:) = inf;
% x_ub(end,end) = 20;

optionsFMINCON = optimoptions(@fmincon, 'Algorithm', 'interior-point', 'Display', 'iter','maxFunEvals', 1e4);
optimal_trajectory = fmincon(@objective_function, x_init, [],[],[],[], x_lb, x_ub, @(x) collocation_constraints(x,parameters), optionsFMINCON);

solution = optimal_trajectory;