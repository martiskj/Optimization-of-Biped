m = 1;
k = 60;
b = 1;
xs = 2;
g = 9.81;
tMax = 30; 

parameters = [k, xs, g, m, b];
tspan = [0 tMax];
x_init = [10;0];
[tsim, solution] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);

%%

plot(tsim, solution);
grid on;