function [sampledTrajectory, time] = calc_init_trajectory(x_init, N, tMax, parameters)
    %% sampledTrajectory = calc_init_trajectory(x_init, N, tMax, parameters)
    tspan = [0 tMax];
    [tsim, exact_solution] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);
    time = linspace(0, tMax, N);

    pointIndexes = [];
    for i = 1:length(time)
        [~, index] = min(abs(tsim - time(i)));
        pointIndexes = [pointIndexes, index];
    end

    sampledTrajectory = [];
    for i = 1:length(pointIndexes)
       sampledTrajectory = [sampledTrajectory; exact_solution(pointIndexes(i), :)]; 
    end
    sampledTrajectory = sampledTrajectory';
end