function animate_pendulum(states)
    %% animate_pendulum(states)
    % shows an animation of the pendulum, given the states. Note, the
    % stateformat is
    %
    %   +----------+----+
    %   |  states  |time|
    %   +----------+----+
    %
    % Where 'time' is a columnvector of zeros and endTime as the last
    % element.
    
    simulation.endTime         = states(end,end);
    states = states(:,1:end-1);
    N = length(states);
    simulation.timeStep = simulation.endTime / (N-1);

    cart.Positions  = states(3,:);
    pendulum.Angles = states(1,:);

    [~, ~, Lc, ~, ~, ~] = set_parameters();

    cart.Width = .3;
    cart.Height = .18;
    cart.Polygon.X = ([0 1 1 0]-.5)*cart.Width;
    cart.Polygon.Y =  [0 0 1 1]*cart.Height;

    pendulum.Mass.Radius = .07;
    a = 2*pi*[0:.01:1];
    pendulum.Mass.Polygon.X = pendulum.Mass.Radius*cos(a);
    pendulum.Mass.Polygon.Y = pendulum.Mass.Radius*sin(a);

    figure(101); clf; grid on; hold on
    axis image
    axis([-4 4 -1 3]); 

    %% Plotting.
    n=1;
    x_now = cart.Positions(n);
    theta_now = pendulum.Angles(n);
    dxp = -Lc*sin(theta_now);
    dyp = Lc*cos(theta_now);

    p1 = patch(x_now+cart.Polygon.X, cart.Polygon.Y, 'c', 'LineWidth', 1);
    p2 = plot(x_now+[0 dxp],cart.Height+[0 dyp],'k-','LineWidth',2);
    p3 = patch(x_now+dxp+pendulum.Mass.Polygon.X,cart.Height+dyp+pendulum.Mass.Polygon.Y,'c','LineWidth',1);
    drawnow

    for n=2:N
        pause(simulation.timeStep)
        x_now = cart.Positions(n);
        theta_now = pendulum.Angles(n);
        dxp = -Lc*sin(theta_now);
        dyp = Lc*cos(theta_now);
        set(p1,'XData',x_now+cart.Polygon.X);
        set(p2,'XData',x_now+[0 dxp], 'YData',cart.Height+[0 dyp]);
        set(p3,'XData',x_now+dxp+pendulum.Mass.Polygon.X, 'YData',cart.Height+dyp+pendulum.Mass.Polygon.Y);
        drawnow
    end
end
