function y = fourier_ramp(x, N, L, fmax)
    %% y = fourier_ramp(x, N, L, fmax)
    n = 1:N;
    bn = ((2*L*(L*sin((pi*fmax*n)/L) - pi*fmax*n.*cos((pi*fmax*n)/L)))./(pi^2*n.^2) - (2*L*fmax*(cos(pi*n) - cos((pi*fmax*n)/L)))./(pi*n))/L;
    y = sum(bn.*sin(n*pi*x/L));
end