function [M, mp, Lc, g, mu, Jp] = set_parameters()

M = 5; % Cart mass
mp = 1; % Pendulum mass
Lc = 1; % Length to center of mass of pendulum
g = 9.81; % Gravity
mu = 0.1 % Coefficient of friction
Jp = 0; % to be set... Jp=0 means pendulum has a "point mass"
