
function solution = run_direct_collocation(initial_guess, parameters)
    %% Starts optimization by direct collocation based on the guessed initial trajectory
    % solution = run_direct_collocation(initial_guess, parameters)

    %% Optimization
    solution = optimization(initial_guess, parameters);

end