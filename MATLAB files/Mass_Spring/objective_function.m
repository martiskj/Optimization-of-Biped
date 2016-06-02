function cost = objective_function(x)

    %% Objective function for the optimization
    %
    % cost = objective_function(x)
    
    %% Try to find largest possible displacement of mass spring system

    cost = -max(x(1, 1:end-1));

end