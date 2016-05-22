function cost = objective_function_fminsearch(x, x_lb, x_ub, parameters)

%% Try to find largest possible displacement of mass spring system

% Need to try different weights 
dynamics_weight = 10000;
pos_weight = 1;
ub_weight = 1e8;
lb_weight = 1e8;

[~, ceq] = collocation_constraints(x, parameters);

dynamics_cost = sum(ceq);
pos_cost = -x(1,1);%-max(x(1, 1:end-1);

[dim, ~] = size(x);
ub_cost = 0;
lb_cost = 0;

for i=1:length(x)
    for j=1:dim
        if(x(j,i) > x_ub(j,i))
           ub_cost = ub_cost + abs(x(j,i) - x_ub(j,i));
        end
        if(x(j,i) < x_lb(j,i))
           lb_cost = lb_cost + abs(x_lb(j,i) - x(j,i));
        end
    end
end


cost = dynamics_cost*dynamics_weight + pos_cost*pos_weight + ub_cost*ub_weight + lb_cost*lb_weight; 

