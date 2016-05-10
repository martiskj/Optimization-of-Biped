function [c,ceq] = collocation_constraints(x,parameters)
%% Defines constraints via vectors c and ceq
% c <= 0
% ceq = 0
%
% The collocation constraints are posed in integral form.
% Approximating done with the trapezoidation method: x_(k+1) = x_k + h_k/2*(f_(k+1) + f_k)
%%

h_k = parameters(end);
N = length(x);
ceq = zeros(2*(N+1),1);

for k=2:N
    ceq(2*k-1:2*k) = x(:,k-1) - x(:,k) + h_k/2 * (dynamics(x(:,k), parameters) + dynamics(x(:,k-1), parameters));
end

% Boundary constraints (start velocity = 0)
ceq(1:2) = [0, x(2,1)];
ceq(end-1:end) = [0, 0];

% No inequality constraints
c = [];
