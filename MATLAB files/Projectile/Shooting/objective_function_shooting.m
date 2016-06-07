function cost = objective_function(x_init, N, parameters)
    x_target = parameters(3);
    y_target = parameters(4);
    dx_0 = x_init(2);
    dy_0 = x_init(4);
    endTime = x_init(end);
    time = linspace(0, endTime, N);
    
    [~, simulation] = ode45(@(t,x) dynamics(x,t,dx_0,dy_0,parameters), time, x_init(1:end-1));
    simulation = simulation';
    
    dx_0 = simulation(2,1);
    dy_0 = simulation(4,1);
    x_end = simulation(1,end);
    y_end = simulation(3,end);
    
    energy = dx_0^2 + dy_0^2;
    target_cost = (x_target - x_end)^2 + (y_target - y_end)^2;

    cost = energy + 2000*target_cost;
end