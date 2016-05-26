function solution = optimization(x_init, parameters)

%% Optimization by direct collocation
% Uses trapezoid method (assumes dynamics are linear between grid points)
% Possible to try a more sophisticated approach


%% Try to find largest possible displacement for mass-spring system
% Path constraints (no constraints on velocity)
x_lb = zeros(2,length(x_init));
x_lb(1,:) = 0;
x_lb(2,:) = -inf;
x_lb(end,end) = 3;
x_ub = zeros(2,length(x_init));
x_ub(1,:) = 6;
x_ub(2,:) = inf;
x_ub(end,end) = 3;

optionsFMINCON = optimoptions(@fmincon, 'Algorithm', 'active-set', 'Display', 'iter','maxFunEvals', 1e5);
optimal_trajectory = fmincon(@objective_function, x_init, [],[],[],[], x_lb, x_ub, @(x) collocation_constraints(x,parameters), optionsFMINCON);

solution = optimal_trajectory;