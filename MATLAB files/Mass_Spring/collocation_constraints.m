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
ceq = zeros(2*N+1,1);
for k=1:N-1
    ceq(k:k+1) = x(:,k) - x(:,k+1) + h_k/2 * (dynamics(x(:,k+1),parameters) + dynamics(x(:,k),parameters));
end

% Boundary constraints (start velocity = 0)
ceq = [ceq; x(2,1)];

% No inequality constraints
c = [];
