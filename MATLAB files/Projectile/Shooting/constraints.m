function [c, ceq] = constraints(x, parameters)
    g = parameters(2);
    ceq = [x(1)-0;              %Start in x = 0
           x(3)-0];              %Start in y = 0
       
    c = [];
end