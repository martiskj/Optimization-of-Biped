function plot_solution(solution)

    figure;
    N = length(solution)-1;
    maxTime = solution(end, end);
    step = maxTime /(N-1);
    t = 0:step:maxTime;

    plot(solution(1,1:end-1),solution(3,1:end-1));
    title('Optimal trajectory projectile')
    grid on;

    fprintf('time = %f', solution(end,end));

end