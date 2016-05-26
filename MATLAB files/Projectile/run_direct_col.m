
function run_direct_collocation(N, initial_guess)

    %% Guess initial trajectory
    parameters = set_parameters();
%     endTime = x(end,end);
%     stepTime = endTime/(N-1);
% 
%     t_guess = linspace(0, endTime, N);
%     % x_init = [0; 2; 0; 20];
%     [t_guess, initial_guess] = ode45(@(t, x) dynamics(x, t, x_init(2), x_init(4), parameters), t_guess, x_init);
% 
%     plot(initial_guess(:,1), initial_guess(:,3));
%     xlabel('x');
%     ylabel('y');
%     title('Initial guess');
%     grid on;
% 
%     % initial_guess = [initial_guess', [0; 0; 0; guess.endTime]];
%     initial_guess = [initial_guess, [0; 0; 0; guess.endTime]];
% 
%     % Cost for first guess
%     cost = objective_function(initial_guess)


    %% Optimization
    solution = optimization(initial_guess, parameters);

    %% Plot
    plot_solution(solution)

end