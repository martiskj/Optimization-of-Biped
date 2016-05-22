function cost = objective_function(x)

%% Try to find largest possible displacement of mass spring system

cost = -x(1,1);%-max(x(1, 1:end-1));