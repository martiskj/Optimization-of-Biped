function x_dot = dynamics(x, t, dx_0, dy_0, parameters)
    %% x_dot = f(x,t)
    % Dynamics for the system
    % This is to be used in the collocation constraints

    %% Projectile system
    m = parameters(1); g = parameters(2);

    x1 = x(1); %x
    x2 = x(2); %dx
    x3 = x(3); %y
    x4 = x(4); %dy

    x1_dot = dx_0;
    x2_dot = 0;
    x3_dot = dy_0 - g*t;
    x4_dot = -g;

    x_dot = [x1_dot, x2_dot, x3_dot, x4_dot]';
    
end