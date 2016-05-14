function x_dot = dynamics(x, t, parameters)
    %% x_dot = dynamics(x, t, parameters)
    
    %x(1) = y
    %x(2) = y_dot
%     m = parameters(1);
%     k = parameters(2);
%     xs = parameters(3);
%     g = parameters(4);
%     
%     dim = length(x);
%     x_dot = zeros(dim,1);
%     x_dot(1) = x(2);
%     x_dot(2) = -g - k/m*(x(1) - xs)*heaviside(xs - x(1));
    
    %% Energyloss:
    %x(1) = yM
    %x(2) = yM_dot
    %x(3) = ym
    %x(4) = ym_dot
    
    k  = parameters(1);
    xs = parameters(2);
    g  = parameters(3);
    M  = parameters(4);
    m  = parameters(5);
    
    Fspring = k*(x(1) - x(3) - xs);
    Fnorm_M = (M*g + Fspring)*heaviside(M*g + Fspring)*heaviside(-x(1));
    Fnorm_m = (m*g - Fspring)*heaviside(m*g - Fspring)*heaviside(-x(3));
    velocity_M = x(2) - x(2)*heaviside(-x(2))*heaviside(-x(1));
    velocity_m = x(4) - x(4)*heaviside(-x(4))*heaviside(-x(3));
    
    x_dot = zeros(length(x),1);
    x_dot(1) = velocity_M;
    x_dot(2) = -g - Fspring/M + Fnorm_M/M;
    x_dot(3) = velocity_m;
    x_dot(4) = -g + Fspring/m + Fnorm_m/m;
    
end




