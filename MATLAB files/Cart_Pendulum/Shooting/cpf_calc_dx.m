function [dX, taup, Fy, Fx] = cpf_calc_dx(t,X)

%% Function outputs derivatives of all states, for use with ode45.
% Also outputs the pendulum torque required, for calculation of
% Cost of Transport later...
%
% Define states. Only x and dx are "open". y=0 (wheels on ground),
% and we assume the angle is set to follow some exact trajectory over
% time:

x = X(1);
dx = X(2);
y = 0;
dy = 0;
d2y = 0; % needed for calculation of Fy...
[theta,dtheta,d2theta] = parameters_to_thetas(t); % Martin: We need parameters as argument? Tried different x_inits, got different thetaVectors out, but that must be because of different t-vectors?

[M,mp,Jp,Lc,g,mu] = set_parameters;
Fy = - Lc*mp*cos(theta)*dtheta^2 + M*g + g*mp + d2y*(M + mp) - Lc*d2theta*mp*sin(theta);

if 0 %Fy<0 % cart would lift off ground... catch this, in case it happens...
    fprintf('Negative ground reaction force? Crazy pendulum motion causing cart lift-off?\n')
    %keyboard
    % If you are here, then the equations may need to be rewritten, to
    % treat y as an open variable?
end

%% Now, calculate the friction force
% Two cases: If cart is moving, apply negative friction, to resist motion.
% Otherwise, calculate the GRF (ground reaction force) needed to prevent
% cart motion (i.e., so d2x=0) and see whether this is less than
% mu*Fy, the max friction force, based on the normal force.
bDoesSlide = false;
if abs(dx)>1e-6  % Not sure if this should just be zero?
    Fx = -mu*Fy*sign(dx);
    bDoesSlide = true;
else
    %dx = 0; % force to zero?
    d2x = 0; % assume, for now...
    Fx_no_motion = Lc*mp*sin(theta)*dtheta^2 + d2x*(M + mp) - Lc*d2theta*mp*cos(theta);
    Fx = Fx_no_motion;
    if abs(Fx_no_motion) > mu*Fy
        bDoesSlide = true;
        Fx = sign(Fx_no_motion)*mu*Fy;
        % Fx (friction force) couples with: d2x, d2theta:
        % Fx = Lc*mp*sin(theta)*dtheta^2 + d2x*(M + mp) - Lc*d2theta*mp*cos(theta)
        
    end
end
if bDoesSlide  % otherwise, d2x=0
    d2x = (1/(M+mp)) * ...
        (Fx - ( Lc*mp*sin(theta)*dtheta^2 - Lc*d2theta*mp*cos(theta)));
end

%% Equations of motion (EOMs), derived via Lagrangian approach:
%
%% Fx (friction force) couples with: d2x, d2theta:
%Fx = Lc*mp*sin(theta)*dtheta^2 + d2x*(M + mp) - Lc*d2theta*mp*cos(theta)
%
%% taup (pendulum torque) couples with: d2x, d2theta, d2y:
%taup = d2theta*(Jp + (mp*(2*Lc^2*cos(theta)^2 + 2*Lc^2*sin(theta)^2))/2) - (mp*(2*Lc*dtheta*sin(theta)*(dx - Lc*dtheta*cos(theta)) - 2*Lc*dtheta*cos(theta)*(dy - Lc*dtheta*sin(theta))))/2 + (dtheta*mp*(2*Lc*sin(theta)*(dx - Lc*dtheta*cos(theta)) - 2*Lc*cos(theta)*(dy - Lc*dtheta*sin(theta))))/2 - Lc*d2x*mp*cos(theta) - Lc*d2y*mp*sin(theta) - Lc*g*mp*sin(theta)
%
%% Fy (ground reaction force) is set by: d2y, d2theta
%Fy = - Lc*mp*cos(theta)*dtheta^2 + M*g + g*mp + d2y*(M + mp) - Lc*d2theta*mp*sin(theta)




% taup (pendulum torque) couples with: d2x, d2theta, d2y:
taup = d2theta*(Jp + (mp*(2*Lc^2*cos(theta)^2 + 2*Lc^2*sin(theta)^2))/2) -...
    (mp*(2*Lc*dtheta*sin(theta)*(dx - Lc*dtheta*cos(theta)) -...
    2*Lc*dtheta*cos(theta)*(dy - Lc*dtheta*sin(theta))))/2 +...
    (dtheta*mp*(2*Lc*sin(theta)*(dx - Lc*dtheta*cos(theta)) - ...
    2*Lc*cos(theta)*(dy - Lc*dtheta*sin(theta))))/2 - ...
    Lc*d2x*mp*cos(theta) - Lc*d2y*mp*sin(theta) - Lc*g*mp*sin(theta);

dX = [dx;d2x];  % Derivative of states

