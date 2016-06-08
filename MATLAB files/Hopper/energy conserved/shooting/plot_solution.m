function plot_solution(solution, tspan, parameters)
    %% plot_solution(solution, tspan, parameters)
    [tsim, simulation] = ode45(@(t, x) dynamics(x, t, parameters), tspan, solution);
    
    figure('units','normalized','position',[.1 .1 .4 .8])
    subplot(2,1,1);
    plot(tsim, simulation(:,1));
    xlabel('Time');
    ylabel('Position')
    title('Optimal Trajectory Position')
    grid on;

    subplot(2,1,2)
    plot(tsim, simulation(:,2));
    xlabel('Time');
    ylabel('Velocity')
    title('Optimal Trajectory Velocity')
    grid on;
    
    set(gcf, 'PaperPositionMode', 'auto');
    print -depsc2 hopper_shooting_result.eps
end