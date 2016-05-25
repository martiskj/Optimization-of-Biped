function x_dot = dynamics(x, parameters)
    %% x_dot = dynamics(x, t, parameters)
    
    m = parameters(1);
    k = parameters(2);
    xs = parameters(3);
    g = parameters(4);
    
    dim = length(x);
    x_dot = zeros(dim,1);
    x_dot(1) = x(2);
    x_dot(2) = -g - k/m*(x(1) - xs)*heaviside(xs - x(1));    
end