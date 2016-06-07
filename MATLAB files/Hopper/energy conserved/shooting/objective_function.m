function cost = objective_function(x_init, tspan, parameters)
    %% cost = objective_function(x_init, tspan, parameters)
    [tsim, simulation] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);
    x = simulation(:,1);
    dx = simulation(:,2);
    cost = - 10*x(1) + 1e3*min(x.^2);
end