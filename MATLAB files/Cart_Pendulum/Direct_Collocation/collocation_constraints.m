function [c,ceq] = collocation_constraints(x, parameters)
    %% [c,ceq] = collocation_constraints(x, parameters)
    % Defines constraints via vectors c and ceq
    % c <= 0
    % ceq = 0
    %
    % The collocation constraints are posed in integral form.
    % Approximating done with the trapezoidation method: x_(k+1) = x_k + h_k/2*(f_(k+1) + f_k)

    N = length(x) - 1;
    endTime = x(end, end);
    step = endTime / (N-1);

    u = x(7, 1:end-1);
    x = x(1:6, 1:end-1);

    [dim, ~] = size(x);
    ceq = zeros(dim*(N+1),1);

    for k=2:N
        ceq(dim*(k-1)+1:dim*k) = x(:,k-1) - x(:,k) + step/2 * (dynamics(x(:,k), u(:,k), parameters) + dynamics(x(:,k-1), u(:,k), parameters));
    end

    %% Boundary constraints for states
    % To set no boundary, set the boundary to be equal to the state, i.e.
    % boundary.startVelocity = x(2,1) will set no constraint on startVelocity.

    boundary.cart.startPosition.X = 0;
    boundary.cart.startVelocity.X = 0;
    boundary.cart.startPosition.Y = 0;
    boundary.cart.startVelocity.Y = 0;
    boundary.cart.endPosition.X = x(3, end);
    boundary.cart.endVelocity.X = x(4, end);
    boundary.cart.endPosition.Y = x(5, end);
    boundary.cart.endVelocity.Y = x(6, end);

    boundary.pendulum.startPosition = 0;
    boundary.pendulum.startVelocity = 0;
    boundary.pendulum.endPosition = x(1, end);
    boundary.pendulum.endVelocity = x(2, end);

    ceq(1:6)        = [boundary.pendulum.startPosition - x(1,1);
                       boundary.pendulum.startVelocity - x(2,1);
                       boundary.cart.startPosition.X   - x(3,1);
                       boundary.cart.startVelocity.X   - x(4,1);
                       boundary.cart.startPosition.Y   - x(5,1);
                       boundary.cart.startVelocity.Y   - x(6,1)]';

    ceq(end-5:end)  = [boundary.pendulum.endPosition - x(1,end);
                       boundary.pendulum.endVelocity - x(2,end);
                       boundary.cart.endPosition.X   - x(3,end);
                       boundary.cart.endVelocity.X   - x(4,end);
                       boundary.cart.endPosition.Y   - x(5,end);
                       boundary.cart.endVelocity.Y   - x(6,end)]';
    c = [];
end
