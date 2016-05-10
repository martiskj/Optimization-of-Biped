function [theta,dtheta,d2theta,Time_cycle] = parameters_to_thetas(t,parameter_list)

% This function sets the description of pendulum motion, as a function
% of time.
%
% Eventually, this would be parameterized, so it would either need
% additional function inputs, or it would need to load data, etc...

persistent Pvals

%keyboard
if isempty(Pvals)
%    Pvals = [0 3 10 5 4];  % default set...
    Pvals = [0 3 10 5 4 0 0];  % default set...
end

if exist('parameter_list','var') && ~isempty(parameter_list)
    %fprintf('Resetting theta(t) parameters... Pvals =\n')
    %fprintf('%0.4f  ',Pvals);
    %fprintf('\n');
    Pvals = parameter_list;
    % keyboard%
end

% Pvals

tmax = 1*30; % only repeat this long. Then "slow down" pendulum to stop
d2th_max = 100;

if length(Pvals)>=8
    Time_cycle = Pvals(8); % whole thing repeats this often
else
    Time_cycle = 1;
end
    
offset_theta = Pvals(1)*pi/180; % an offset angle, for theta? ADD AT END!
As = [Pvals(2) Pvals(4) Pvals(6)]*pi/180;
Ac = [Pvals(3) Pvals(5) Pvals(7)]*pi/180;
%As = [Pvals(2) Pvals(4) 0]*pi/180;
%Ac = [Pvals(3) Pvals(5) 0]*pi/180;
w = [1 2 3]*(2*pi/Time_cycle);

%% Below, this could be a SUM of sine wave functions, or a polynomial,
% etc...  The idea is to allow for open parameters, and a variety of
% types of waveforms.  (A perfect sine wave isn't enough yet, but
% its here as an example.)
%theta = A*cos(w*t);
%dtheta = -A*w*sin(w*t); % start with zero velocity?
%d2theta = -A*w^2*cos(w*t);

theta = 0*t;
dtheta = 0*t;
d2theta = 0*t;
for n=1:length(As)
    theta = theta + As(n)*sin(w(n)*t);
    dtheta = dtheta + As(n)*w(n)*cos(w(n)*t);
    d2theta = d2theta - As(n)*w(n)^2*sin(w(n)*t);
end
for n=1:length(Ac)
    theta = theta + Ac(n)*cos(w(n)*t);
    dtheta = dtheta - Ac(n)*w(n)*sin(w(n)*t);
    d2theta = d2theta - Ac(n)*w(n)^2*cos(w(n)*t);
end

%% After one cycle, let d2theta be a constant magnitude
% deceleration, until dtheta = 0...

fi = find(t>tmax);
if ~isempty(fi)
    
    th = 0*tmax;
    dth = 0*tmax;
    %d2th = 0*tmax;
    for n=1:length(As)
        th = th + As(n)*sin(w(n)*tmax);
        dth = dth + As(n)*w(n)*cos(w(n)*tmax);
        %d2th = d2th - As(n)*w(n)^2*sin(w(n)*tmax);
    end
    for n=1:length(Ac)
        th = th + Ac(n)*cos(w(n)*tmax);
        dth = dth - Ac(n)*w(n)*sin(w(n)*tmax);
        %d2th = d2th - Ac(n)*w(n)^2*cos(w(n)*tmax);
    end
    
    
    t_final = abs(dth/d2th_max);
    d2th = -sign(dth)*d2th_max;
    d2theta(fi) = d2th;
    dtheta(fi) = dth + d2th*(t(fi) - tmax);
    fi2 = find((dtheta(fi)*dth)<0);
    dtheta(fi(fi2)) = 0; % comes to rest
    
    theta(fi) = th + dth*(t(fi) - tmax) + .5*d2th*(t(fi) - tmax).^2;
    theta_final = th + dth*(t_final) + .5*d2th*(t_final).^2;
    theta(fi(fi2)) = theta_final;
    
    d2theta(fi(fi2)) = 0; % turn off acceleration, when dtheta = 0
    
end

%% Add any offset at the end:
theta = theta + offset_theta;
