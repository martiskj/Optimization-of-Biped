function [c,ceq] = collocation_constraints(x,parameters)
    %% [c,ceq] = collocation_constraints(x,parameters)
    %
    % Defines constraints via vectors c and ceq:
    % c <= 0
    % ceq = 0
    % The collocation constraints are posed in integral form.
    % Approximating done with the trapezoidation method: x_(k+1) = x_k + h_k/2*(f_(k+1) + f_k)
    
    %%
    N = length(x) - 1;
    endTime = x(end, end);
    step = endTime / (N-1);
    ceq = zeros(4*(N+1),1);

    dx0 = x(2,1);
    dy0 = x(4,1);
    t = linspace(0, endTime, N);

    for k=2:N
        ceq(4*k-3:4*k) = x(:,k-1) - x(:,k) + step/2 * (dynamics(x(:,k), t(k), dx0, dy0, parameters) + dynamics(x(:,k-1), t(k-1), dx0, dy0, parameters));
    end

    %% Boundary constraints for states
    % To set no boundary, set the boundary to be equal to the state, i.e.
    % boundary.startVelocity = x(2,1) will set no constraint on startVelocity.

    boundary.start_x = 0; 
    boundary.start_dx = x(2,1);
    boundary.start_y = 0;
    boundary.start_dy = x(4,1);
    boundary.end_x = 10; % Hit target
    boundary.end_dx = x(2,end-1);
    boundary.end_y = 0; % Stop when hit the ground
    boundary.end_dy = x(4,end-1);

    ceq(1:4)        = [boundary.start_x - x(1,1), boundary.start_dx - x(2,1), boundary.start_y - x(3,1), boundary.start_dy - x(4,1)];
    ceq(end-3:end)  = [boundary.end_x - x(1,end-1), boundary.end_dx - x(2,end-1), boundary.end_y - x(3,end-1), boundary.end_dy - x(4,end-1)];

    c = [];

end