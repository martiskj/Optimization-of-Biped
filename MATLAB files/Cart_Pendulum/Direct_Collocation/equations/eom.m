%% Calculates the equations of motion for the cart-pendulum system

clear
syms xp yp x y M mp Jp Lc g theta taup f

xp = x-Lc*sin(theta);
yp = y+Lc*cos(theta);
GC = [{'x'},{'theta'},{'y'}];

dxp = fulldiff(xp,GC);
dyp = fulldiff(yp,GC);
dtheta = fulldiff(theta,GC);

dx = fulldiff(x,GC);
dy = fulldiff(y,GC);

V = mp*g*(yp) + M*g*y;
Tstar = (1/2)*M*(dx^2 + dy^2) + (1/2)*mp*(dxp^2+dyp^2) + (1/2)*Jp*(dtheta^2);

L = Tstar - V;

eqn1 = simplify(fulldiff(diff(L,dx),GC) - diff(L,x)) == f;
eqn2 = simplify(fulldiff(diff(L,dtheta),GC) - diff(L,theta)) == taup;
eqn3 = simplify(fulldiff(diff(L,dy),GC) - diff(L,y)) == 0;

syms d2theta d2x d2y

[d2theta, d2x, d2y] = solve([eqn1, eqn2, eqn3], [d2theta, d2x, d2y]);
taup = solve(eqn2, taup);

d2theta = simplify(d2theta)
d2x = simplify(d2x)
d2y = simplify(d2y)
taup = simplify(taup)

% To display with latex syntax:
% >>latex(d2theta)
% etc.