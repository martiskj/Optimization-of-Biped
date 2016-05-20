function main_shooting(x_init)
m = 1;
k = 60;
xs = 2;
g = 9.81;
b = 1;
tMax = 5; 
parameters = [k, xs, g, m, b];
tspan = [0 tMax];

x_lb = [0; -inf];
x_ub = [6; inf];
optimal_solution = fmincon(@(x) objective_function_shooting(x, tspan, parameters), x_init, [],[],[],[],x_lb, x_ub);

%% Plot the solution:
% 
% [tsim, simulation] = ode45(@(t, x) dynamics(x, t, parameters), tspan, optimal_solution);
% ground = zeros(1, length(tsim));
% plot(tsim, simulation, tsim, ground);
end
