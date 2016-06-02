function solution = optimization(x_init, parameters)
%% Optimization by direct collocation
% Uses trapezoid method (assumes dynamics are linear between grid points)
% Possible to try a more sophisticated approach

    [dim_x, ~] = size(x_init);

    % Path constraints
    x_lb = zeros(dim_x,length(x_init));
    x_lb(1,:) = -pi/2;  %theta
    x_lb(2,:) = -2*pi;  %dtheta
    x_lb(3,:) = -inf;   %x
    x_lb(4,:) = -5;     %dx
    x_lb(5,:) = -0;     %y
    x_lb(6,:) = -0;     %dy
    x_lb(7,:) = -inf;   %taup
    x_lb(end, end) = 2; %time 

    x_ub = zeros(dim_x,length(x_init));
    x_ub(1,:) = pi/2;   %theta
    x_ub(2,:) = 2*pi;   %dtheta
    x_ub(3,:) = inf;    %x
    x_ub(4,:) = 5;      %dx
    x_ub(5,:) = 0;      %y
    x_ub(6,:) = 0;      %dy
    x_ub(7,:) = inf;    %taup
    x_ub(end, end) = 10;%time

    optionsFMINCON = optimoptions(@fmincon, 'Algorithm', 'interior-point', 'Display', 'iter', 'maxFunEvals', 6e4);
    optimal_trajectory = fmincon(@objective_function, x_init, [],[],[],[], x_lb, x_ub, @(x) collocation_constraints(x,parameters), optionsFMINCON);

    solution = optimal_trajectory;