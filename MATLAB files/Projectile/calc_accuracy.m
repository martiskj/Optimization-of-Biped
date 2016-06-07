function error = calc_accuracy(solution, parameters)
    %% error = calc_accuracy(solution, parameters)

    trajectoryTime = solution(end, end);
    solutionTimeLess = solution(: ,1:end-1);
    N = length(solutionTimeLess);
    t = linspace(0,trajectoryTime,N);
    dx0 = solution(2,1);
    dy0 = solution(4,1);
    g = parameters(2);
    
    true.x = dx0.*t;
    true.y = dy0.*t - 0.5*g.*t.^2;
    true.dx = dx0.*ones(1,N);
    true.dy = dy0 - g.*t;
    
    trueSolution = [true.x;true.dx;true.y;true.dy];
    error = abs(trueSolution - solutionTimeLess);
end