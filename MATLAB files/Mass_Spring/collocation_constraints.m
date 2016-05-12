function [c,ceq] = collocation_constraints(x,parameters)
%% Defines constraints via vectors c and ceq
% c <= 0
% ceq = 0
%
% The collocation constraints are posed in integral form.
% Approximating done with the trapezoidation method: x_(k+1) = x_k + h_k/2*(f_(k+1) + f_k)
%%
N = length(x) - 1;
endTime = x(end, end);
step = endTime / (N-1);
ceq = zeros(2*(N+1),1);

for k=2:N
    ceq(2*k-1:2*k) = x(:,k-1) - x(:,k) + step/2 * (dynamics(x(:,k), parameters) + dynamics(x(:,k-1), parameters));
end

%% Boundary constraints for states
% To set no boundary, set the boundary to be equal to the state, i.e.
% boundary.startVelocity = x(2,1) will set no constraint on startVelocity.

boundary.startPosition = x(1,1); 
boundary.startVelocity = 0;
boundary.endPosition = x(1,1);
boundary.endVelocity = x(2, end-1);

ceq(1:2)        = [boundary.startPosition - x(1,1),      boundary.startVelocity - x(2,1)];
ceq(end-1:end)  = [boundary.endPosition   - x(1, end-1), boundary.endVelocity   - x(2, end-1)];
%c = [x(end, end) - boundary.maxTime];
c = [];
