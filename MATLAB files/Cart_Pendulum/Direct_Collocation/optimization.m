function solution = optimization(x_init, parameters)

%% Optimization by direct collocation
% Uses trapezoid method (assumes dynamics are linear between grid points)
% Possible to try a more sophisticated approach


%% Try to energy efficient pendulum movement to move a cart-pendulum system

% Path constraints
x_lb = zeros(2,length(x_init));
x_lb(1,:) = -pi/2;
x_lb(2,:) = -inf;
x_ub = zeros(2,length(x_init));
x_ub(1,:) = pi/2;
x_ub(2,:) = inf;

optionsFMINCON = optimoptions(@fmincon, 'Algorithm', 'interior-point', 'Display', 'iter');
optimal_trajectory = fmincon(@objective_function, x_init, [],[],[],[], x_lb, x_ub, @(x) collocation_constraints(x,parameters), optionsFMINCON);

solution = optimal_trajectory;