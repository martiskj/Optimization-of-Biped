function x_dot = dynamics(x, t, parameters)
    %% x_dot = dynamics(x, t, parameters)
    
    % x(1) = position
    % x(2) = velocity
    k  = parameters(1);
    xs = parameters(2);
    g  = parameters(3);
    m  = parameters(4);
    b  = parameters(5);
    
    x_dot = zeros(length(x), 1);
    x_dot(1) = x(2);
    x_dot(2) = -g + (-b*x(2) + k*(xs - x(1)))/m * heaviside(xs - x(1));
end




