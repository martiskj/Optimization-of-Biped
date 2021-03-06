%% Guess initial trajectory
parameters = set_parameters();
guess.endTime = 5;
N = 50;
x_init = [0; 2; 0; 20];

initial_guess = calc_init_trajectory(x_init, N, guess, parameters);

%% Optimize trajectory
solution = run_direct_collocation(initial_guess, parameters);
plot_solution(solution);
