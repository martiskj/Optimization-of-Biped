function plot_solution(solution)
    %% plot_solution(solution)
    N = length(solution)-1;
    maxTime = solution(end, end);
    step = maxTime /(N-1);
    t = 0:step:maxTime;

    figure('units','normalized','position',[.1 .1 .4 .8])
    subplot(2,1,1);
    plot(t, solution(1,1:end-1));
    xlabel('Time');
    ylabel('Position')
    title('Optimal trajectory position')
    grid on;

    subplot(2,1,2)
    plot(t, solution(2,1:end-1));
    xlabel('Time');
    ylabel('Velocity')
    title('Optimal trajectory velocity')
    grid on;

    set(gcf, 'PaperPositionMode', 'auto');
    print -depsc2 hopper_dc_result.eps
    
    fprintf('end time = %f', solution(end,end));
end