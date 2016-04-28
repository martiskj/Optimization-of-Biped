clc;
clear all;
parameters1 = [ -6.1110  -14.0827   -5.5163   -2.3166    0.9757   -0.8109    0.6758 1];
parameters2 = [0 3 10 5 4 0 1 1];
parameters3 = [0 0 0 0 0 10 0 1];
% parameters3 = [0 10 0 0 0 0 0 1];

%cost_cpf(parameters1, 0,1,0.1)
%%
parameters3 = optimal_parameters_fmincon;
% parameters3 = [0 3 10 5 4 0 1 1];

[~,~,~,Tcycle] = parameters_to_thetas(0,parameters3); 
x0 = [0;0];
Ncycle = 1
Tmax = Ncycle*Tcycle;
tsim = [0 Tmax]; 
Opts = odeset('AbsTol',5e-4,'RelTol',5e-4,'MaxStep',0.005);
[t,xout] = ode45(@cpf_calc_dx, tsim, x0, Opts);
[thetas,~,~,~] = parameters_to_thetas(t,parameters3); 

% cost_cpf(parameters3, 1,1,0.1)

animate_pendulum(t,xout,thetas)


%%
clc;
clear all;
parameters_init = [ -6.1110  -14.0827   -5.5163   -2.3166    0.9757   -0.8109    0.6758 1];
parameters_init = 1*(rand(1,8)-.5) + parameters_init;
optimal_parameters_fminsearch = optimize(parameters_init, 'fminsearch');
optimal_parameters_fmincon = optimize(parameters_init, 'fmincon');

