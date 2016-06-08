function plot_solution(solution)
    t = linspace(0, solution(end,end), N);
    figure;
    plot(t, solution(1:6,1:end-1));
    xlabel('time');
    ylabel('states');
    title('Optimal trajectory theta');
    legend('theta', 'dtheta', 'x', 'dx', 'y', 'dy');

    solution(6, end) = solution(end, end);
    solution = solution(1:6,:);    
end