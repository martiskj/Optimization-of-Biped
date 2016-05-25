function error = calc_accuracy(solution, parameters)
	%% accuracy = calc_accuracy(solution, parameters)	
    tMax = parameters(5);
    time = linspace(0, tMax, length(solution))';
    [~, trueSolution] = ode45(@(t,x) dynamics(x, [], parameters), time, [6;0]);
       
    error = abs(trueSolution' - solution);
	%accuracy = [sum(abs(error(1,:))); sum(abs(error(2,:)))];
end