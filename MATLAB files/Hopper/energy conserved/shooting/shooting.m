m = 1;
k = 60;
xs = 2;
g = 9.81;
tMax = 5; 
parameters = [m, k, xs, g,];
tspan = [0 tMax];
x_init = [3, 0]

x_lb = [0; -inf];
x_ub = [6; inf];
optimal_solution = fmincon(@(x) objective_function_shooting(x, tspan, parameters), x_init, [],[],[],[],x_lb, x_ub);

%% Plot the solution:

[tsim, simulation] = ode45(@(t, x) dynamics(x, t, parameters), tspan, optimal_solution);
ground = zeros(1, length(tsim));
plot(tsim, simulation, tsim, ground);
