function solution = run_shooting(x_init, guess, N, parameters)
    %% Starts optimization by direct collocation based on the guessed initial trajectory
    % solution = run_direct_collocation(initial_guess, guess, parameters)
    
    %%
    x_init = [x_init; guess.endTime];
    
    x_lb = [-inf; -inf;-inf; -inf; 0];
    x_ub = [inf; inf; inf; inf; 10];
       
    initvalues_solution = fmincon(@(x) objective_function_shooting(x, N, parameters), x_init, [],[],[],[],x_lb, x_ub,@(x) constraints(x, parameters));
    
    time = linspace(0, initvalues_solution(end), N);
    dx_0 = initvalues_solution(2);
    dy_0 = initvalues_solution(4);
    [tsim, simulation] = ode45(@(t,x) dynamics(x,t, dx_0, dy_0, parameters), time, initvalues_solution(1:end-1,:));
    solution = simulation';
    solution = [solution, [0; 0; 0; time(end)]];
    
end