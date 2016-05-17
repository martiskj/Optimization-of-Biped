m = 1;
k = 60;
xs = 2;
g = 9.81;
tMax = 5; 

parameters = [m, k, xs, g,];
tspan = [0 tMax];
x_init = [4;0];
[tsim, solution] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);

%%
hold on;
plot(tsim, solution);
%plot(tsim, solution(:,3));
legend()
hold off;
grid on;