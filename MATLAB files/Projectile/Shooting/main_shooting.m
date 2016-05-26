%% Run optimization 
parameters = set_parameters();
N = 50;
guess.endTime = 1;
x_init = [0; %x
          2; %dx
          0; %y
          20;]; %dy

solution = run_shooting(x_init, guess, N, parameters);

%% Plot
plot_solution(solution);
