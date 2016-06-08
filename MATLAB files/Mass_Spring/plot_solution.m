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

<<<<<<< c23ac474ebd32d817717d5c7db2ad748c1672b49
    fprintf('time = %f', solution(end,end));
=======
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 mass_spring_result.eps
fprintf('time = %f', solution(end,end));
>>>>>>> Made more printable plots

end