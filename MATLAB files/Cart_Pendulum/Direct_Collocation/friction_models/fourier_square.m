function y = fourier_square(x, N, L)
%% y = fourier_square(x, N, L)
    n = 1:2:2*N;
    y = 4/pi * sum(1./n.*sin(n*pi*x/L));
end