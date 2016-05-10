function [cost_val, tu, taup, theta, dtheta, d2theta, xu, Fy, COT, speed] = ...
    cost_cpf(params_theta,bPlot,Ncycle,speed_des)

bDebug = false; % to show plots and animation, etc...


if ~exist('speed_des','var') || isempty(speed_des)
    speed_des = -.05; 
end

if exist('bPlot','var') && ~isempty(bPlot) && bPlot
    bDebug = true;
end

if ~exist('Ncycle','var') || isempty(Ncycle)
    Ncycle = 2;
end

%% Below, RESET PARAMS (persistent variables) for theta(t), and also get Tcycle:
if ~exist('params_theta','var')
    params_theta = []; % empty variable will NOT reset theta(t) function...
end
[~,~,~,Tcycle] = parameters_to_thetas(0,params_theta); 

% Run motion for 2 cycles, saving info on 2nd full cycle:
x0 = [0;0]; 
Tmax = Ncycle*Tcycle;
tsim = [0 Tmax]; 
Opts = odeset('AbsTol',5e-4,'RelTol',5e-4,'MaxStep',0.005);
[t,xout] = ode45(@cpf_calc_dx, tsim, x0, Opts);


if bDebug
    %% Draw the cart position and velocity over time:
    figure(11); clf
    subplot(211)
    plot(t,xout)
    xlabel('Time (s)')
    ylabel('Cart States')
    legend('Position (m)','Velocity (m/s)')
    
    %% Draw theta(1), too:
    [theta,dtheta,d2theta,Tcycle] = parameters_to_thetas(t);
    subplot(212)
    plot(t,theta)
    xlabel('Time (s)')
    ylabel('Theta (rad)')
end

%% For all calculations below, look at only the LAST CYCLE of simulation:

%% Find Speed
Dcycle = (xout(end,1) - interp1(t,xout(:,1),Tmax-Tcycle));
speed = Dcycle / Tcycle;

%% Find Cost of Transport (COT), to measure energy use

t1 = Tmax - Tcycle;
fi = find(t>t1);
tu = [t1; t(fi)];  % t_use, to use for one-cycle calculation of energy use
x1 = [interp1(t,xout(:,1),t1), interp1(t,xout(:,2),t1)];
xu = [x1; xout(fi,:)];
Fx = 0*tu; Fy = 0*tu; taup = 0*tu;
for n=1:length(tu)
    [dX, taup(n), Fy(n), Fx(n)] = cpf_calc_dx(tu(n),xu(n,:)');
end

[theta,dtheta,d2theta,Tcycle] = parameters_to_thetas(tu);

Work_pieces_cycle = taup .* dtheta;
dtu = diff(tu);
Work_total_cycle = sum(abs(dtu.*Work_pieces_cycle(1:end-1)));

[M,mp,Jp,Lc,g,mu] = set_parameters;
if abs(Dcycle)<1e-6
    COT = 10000 + Work_total_cycle;
else
    COT =  abs(Work_total_cycle /((M+mp)*g*Dcycle));
end

if bDebug
    %% Show the motion:
    animate_pendulum(t,xout)
end

%params_theta
cost_val = COT; %+ 1e6*(speed-speed_des)^2;
% optimal_temp = params_theta

if 0
    %drawnow('update')
    figure(21); hold on
    plot(speed,COT,'g.')
    A = axis;
    axis([A(1:2) 0 50])
    drawnow
end