function [M,mp,Jp,Lc,g,mu_val] = set_parameters(mu_reset_value)

persistent mu

M = 5; % cart mass
mp = 1; % pendulum mass
Lc = 1; % Length to center of mass of pendulum
g = 9.8; % gravity
Jp = 0; % to be set... Jp=0 means pendulum has a "point mass"

if isempty(mu)
    mu=0.1; % friction coefficient
end

if exist('mu_reset_value','var') && ~isempty(mu_reset_value)
    mu = mu_reset_value;
end

mu_val = mu;