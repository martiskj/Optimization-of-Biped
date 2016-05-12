function [c,ceq] = collocation_constraints(x, u, parameters)
%% Defines constraints via vectors c and ceq
% c <= 0
% ceq = 0
%
% The collocation constraints are posed in integral form.
% Approximating done with the trapezoidation method: x_(k+1) = x_k + h_k/2*(f_(k+1) + f_k)
%%

h_k = parameters(end);
[dim, N] = size(x);
ceq = zeros(dim*(N+1),1);

for k=dim:N
    ceq(dim*k-1:dim*k) = x(:,k-1) - x(:,k) + h_k/2 * (dynamics(x(:,k), u(:,k), parameters) + dynamics(x(:,k-1), u(:,k), parameters));
end

% Boundary constraints
% (theta0 = 0, dtheta0 = 0, x0 = 0, dx0 = 0)
ceq(1:dim) = [x(1,1), x(2,1), x(3,1), x(4,1), 0, 0];
ceq(end-(dim-1):end) = [0, 0, 0, 0, 0, 0];

% Inequality constraints
c = [];
