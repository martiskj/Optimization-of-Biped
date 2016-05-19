function cost = objective_function(x_init, tspan, parameters)
    [tsim, simulation] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);
    cost = -max(simulation(1,:));
end