function animate_pendulum(t,xout,theta)

x = xout(:,1); % position, only
% get "theta" from "parameters_to_thetas.m"
if ~exist('theta','var')
    theta = parameters_to_thetas(t);
end

dt = 0.02;

wc = .3;
hc = .18;
xc = ([0 1 1 0 0]-.5)*wc;
yc = [0 0 1 1 0]*hc;

[M,mp,Jp,Lc,g,mu] = set_parameters;  % only need Lc...

R = .07;
a = 2*pi*[0:.01:1];
xdot = R*cos(a);
ydot = R*sin(a); % to draw pendulum mass...

tani = 0:dt:max(t);
if t(end)>tani(end)
    tani = [tani, t(end)];
end

figure(101); clf; grid on; hold on
axis image
axis([-4 4 -1 3]); 

%% Now, do the plotting.
n=1;
x_now = interp1(t,x,tani(n));
theta_now = interp1(t,theta,tani(n));
dxp = -Lc*sin(theta_now);
dyp = Lc*cos(theta_now);

%% Avoid re-plotting the same objects. Just redefine x and y coords:
p1 = patch(x_now+xc,yc,'c','LineWidth',1);
p2 = plot(x_now+[0 dxp],hc+[0 dyp],'k-','LineWidth',2);
p3 = patch(x_now+dxp+xdot,hc+dyp+ydot,'c','LineWidth',1);
drawnow

for n=2:length(tani)
    pause(dt)
    x_now = interp1(t,x,tani(n));
    theta_now = interp1(t,theta,tani(n));
    dxp = -Lc*sin(theta_now);
    dyp = Lc*cos(theta_now);
    set(p1,'XData',x_now+xc);
    set(p2,'XData',x_now+[0 dxp], 'YData',hc+[0 dyp]);
    set(p3,'XData',x_now+dxp+xdot, 'YData',hc+dyp+ydot);
    drawnow
    
end
