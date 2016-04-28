%% This code has two part.
% 1) Simulate the cart system, and play an animation.
% 2) Run an "optimization" of the system, across a set of speeds.

%% Part 1) Simulate the cart system, and play an animation.
% Run an example motion:

x0 = [0;0]; % cart position=x(1) and velocity=x(2)
Time_cycle = 1; % See "parameters_to_thetas.m", which sets cycle
Num_cycle = 2;
Time_max = Num_cycle*Time_cycle; % Time to simulate motion
% Maybe start before t=0, to let "start up"?
t_sim = [-.1 Time_max]; % time to run simulation

% Set options for ode45 solver:
options_ode = odeset('AbsTol',1e-6,'RelTol',1e-6,'MaxStep',0.01);
[t,xout] = ode45(@cpf_calc_dx,t_sim,x0,options_ode);

% Draw the cart position and velocity over time:
figure(11); clf
plot(t,xout)
xlabel('Time (s)')
ylabel('Cart States')
legend('Position (m)','Velocity (m/s)')

% For all calculations below, look at only the LAST CYCLE of simulation:

% Find Speed
Dist_cycle = (xout(end,1) - interp1(t,xout(:,1),Time_max-Time_cycle));
speed = Dist_cycle / Time_cycle;

% Find Cost of Transport (COT), to measure energy use

t1 = Time_max - Time_cycle;
fi = find(t>t1);
t_use = [t1; t(fi)];  % t_use, to use for one-cycle calculation of energy use
x1 = [interp1(t,xout(:,1),t1), interp1(t,xout(:,2),t1)];
x_use = [xout; x1];
Fx = 0*t_use; Fy = 0*t_use; taup = 0*t_use;
for n=1:length(t_use)
    [dX, taup(n), Fy(n), Fx(n)] = cpf_calc_dx(t_use(n),x_use(n,:)');
end
[theta,dtheta,d2theta,Time_cycle] = parameters_to_thetas(t_use);

Work_pieces_cycle = taup .* dtheta;
dt_use = diff(t_use);
Work_total_cycle = sum(abs(dt_use.*Work_pieces_cycle(1:end-1)));

[M,mp,Jp,Lc,g,mu] = set_parameters;
COT =  abs(Work_total_cycle /((M+mp)*g*Dist_cycle));


animate_pendulum(t,xout)


%% 2) Run an "optimization" of the system, across a set of speeds.
parameters_init = [ -6.1110  -14.0827   -5.5163   -2.3166    0.9757   -0.8109    0.6758 1];
parameters_init = 1*(rand(1,8)-.5) + parameters_init;
optimal_parameters = optimize(0.1, parameters_init, 'fminsearch');

% For animation:
x0 = [0; 0]; 
Time_cycle = 1;
Num_cycle = 2;
Time_max = Num_cycle * Time_cycle;
t_sim = [-.1 Time_max];
options_ode = odeset('AbsTol', 1e-6, 'RelTol', 1e-6, 'MaxStep', 0.01);
[t, xout] = ode45(@cpf_calc_dx, t_sim, x0, options_ode);
theta = parameters_to_thetas(t, optimal_parameters);
animate_pendulum(t, xout, theta)

