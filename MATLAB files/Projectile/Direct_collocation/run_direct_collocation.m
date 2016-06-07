function solution = run_direct_collocation(initial_guess, parameters)
    %% solution = run_direct_collocation(initial_guess, parameters)
    %
    % Starts optimization by direct collocation based on the guessed initial trajectory

    %% Optimization
    solution = optimization(initial_guess, parameters);

end