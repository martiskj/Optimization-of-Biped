function [c, ceq] = constraints(x, parameters)
    g = parameters(2);
    ceq = [x(1)-0;              %Start in x = 0
           x(3)-0;              %Start in y = 0
           2*x(2)*x(4)/g - 10;  %Hit the target
           x(end) - 2*x(4)/g];  %End time when projectile hits the ground
    c = [];
end