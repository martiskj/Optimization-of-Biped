function cost = objective_function(x)

    %% cost = objective_function(x) 
    %
    % Trying to hit the target
    % The cost is the least amount of energy neede to launch the projectile

    dx_0 = x(2,1);
    dy_0 = x(4,1);
    energy = sqrt(dx_0^2 + dy_0^2);
    cost = energy;
    
end