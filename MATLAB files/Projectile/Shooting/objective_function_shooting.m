function cost = objective_function(x_init, N, parameters)

    endTime = x_init(end);
    time = linspace(0, endTime, N);
    
%     [tsim, simulation] = ode45(@(t,x) dynamics(x,t,parameters), time, x_init);
    
    
    dx = x_init(2);
    dy = x_init(4);
    energy = sqrt(dx^2 + dy^2);
    cost = energy;
end