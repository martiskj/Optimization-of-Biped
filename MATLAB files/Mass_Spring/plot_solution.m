function plot_solution(solution)
    figure;
    N = length(solution)-1;
    maxTime = solution(end, end);
    step = maxTime /(N-1);
    t = 0:step:maxTime;

    subplot(2,1,1);
    plot(t, solution(1,1:end-1));
    xlabel('time');
    ylabel('position')
    title('Optimal trajectory position')
    grid on;

    subplot(2,1,2)
    plot(t, solution(2,1:end-1));
    xlabel('time');
    ylabel('velocity')
    title('Optimal trajectory velocity')
    grid on;
    
    set(gcf, 'PaperPositionMode', 'auto');
    fprintf('time = %f', solution(end,end));
end