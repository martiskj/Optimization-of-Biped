%Test dynamics
Tmax = 5;
N = 100;
t = linspace(0,Tmax,N);
x_init = [0;0];
parameters = set_parameters();
[tsim,sol] = ode45(@(t,x) dynamics(x, t, parameters), t, x_init);

plot(sol(:,1),sol(:,2))