function cost = objective_function(x)

%% Try to find largest possible altitude the hopper can reach

cost = -max(x(1, 1:end-1));