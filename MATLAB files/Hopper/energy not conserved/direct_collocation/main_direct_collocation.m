function optimal_solution = main_direct_collocation(N, x_init)
%% Set parameters
m = 1;
k = 60;
xs = 2;
g = 9.81;
b = 1;
tMax = 5; 
parameters = [k, xs, g, m, b, tMax];

[initial_guess, time] = calc_init_trajectory(x_init, N, tMax, parameters);
optimal_solution = optimization(initial_guess, parameters);

spline_interval = linspace(0, tMax, 200);
optimal_solution = spline(time, optimal_solution, spline_interval); 


end

