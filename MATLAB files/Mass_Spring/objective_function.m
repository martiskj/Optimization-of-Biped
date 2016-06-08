function cost = objective_function(x)
    %% Objective function for the optimization
    %
    % cost = objective_function(x)
    
    cost = -max(x(1, 1:end-1));
end