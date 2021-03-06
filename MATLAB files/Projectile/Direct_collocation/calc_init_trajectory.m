function init_trajectory = calc_init_trajectory(x_init, N, guess, parameters)
    %% init_trajectory = calc_init_trajectory(x_init, N, guess, parameters)
    %
    % Calculates a feasible initial guess for the optimization of the trajectory 
    
    %%
    t_guess = linspace(0, guess.endTime, N);
    [t_guess, initial_guess] = ode45(@(t, x) dynamics(x, t, x_init(2), x_init(4), parameters), t_guess, x_init);
    
    initial_guess = [initial_guess', [0; 0; 0; guess.endTime]];
    init_trajectory = initial_guess;
    
end