%% Finding coefficients for Fourier_ramp
syms x fmax n L
a = 1;
a0 = 1/(2*L) * (int(- fmax, x, -L, -fmax) + int(a*x, x, -fmax, fmax) + int(fmax, x, fmax, L));
an = 1/L * (int(-fmax * cos(n*pi*x/L), x, -L, -fmax) + int(a*x*cos(n*pi*x/L), x, -fmax, fmax) + int(fmax*cos(n*pi*x/L), x, fmax, L)); 
bn = 1/L * (int(-fmax * sin(n*pi*x/L), x, -L, -fmax) + int(a*x*sin(n*pi*x/L), x, -fmax, fmax) + int(fmax*sin(n*pi*x/L), x, fmax, L)); 

%% Plot the Fourier_ramp
t = -100:0.5:100;
hold on;
for i=1:length(t)
    plot(t(i), fourier_ramp(t(i), 2000, 100, -70));
end
hold off;
grid on;

%% Plot the Fourier_square
t = -2:0.001:2;
hold on;
for i=1:length(t)
    plot(t(i), fourier_square(t(i), 200, 5));
end
hold off;
grid on;