M = 5;
m = 1;
k = 60;
xs = 2;
g = 9.81;
tMax = 5; 

parameters = [k, xs, g, M, m];
tspan = [0 tMax];
x_init = [10;0;8;0];
[tsim, solution] = ode45(@(t,x) dynamics(x,t,parameters), tspan, x_init);

%%
hold on;
plot(tsim, solution);
%plot(tsim, solution(:,3));
legend()
hold off;
grid on;