clear

syms xp yp x y M mp Jp Lc g theta

xp = x-Lc*sin(theta)
yp = y+Lc*cos(theta)
GC = [{'x'},{'theta'},{'y'}]

dxp = fulldiff(xp,GC)
dyp = fulldiff(yp,GC)
dtheta = fulldiff(theta,GC)

dx = fulldiff(x,GC)
dy = fulldiff(y,GC)

V = mp*g*(yp) + M*g*y
Tstar = (1/2)*M*(dx^2 + dy^2) + (1/2)*mp*(dxp^2+dyp^2) + (1/2)*Jp*(dtheta^2)

L = Tstar - V;

eqn1 = fulldiff(diff(L,dx),GC) - diff(L,x)
eqn2 = fulldiff(diff(L,dtheta),GC) - diff(L,theta)
eqn3 = fulldiff(diff(L,dy),GC) - diff(L,y)

%%
syms d2x d2y d2theta

simplify(d2theta*(Jp + (mp*(2*Lc^2*cos(theta)^2 + 2*Lc^2*sin(theta)^2))/2) - (mp*(2*Lc*dtheta*sin(theta)*(dx - Lc*dtheta*cos(theta)) - 2*Lc*dtheta*cos(theta)*(dy - Lc*dtheta*sin(theta))))/2 + (dtheta*mp*(2*Lc*sin(theta)*(dx - Lc*dtheta*cos(theta)) - 2*Lc*cos(theta)*(dy - Lc*dtheta*sin(theta))))/2 - Lc*d2x*mp*cos(theta) - Lc*d2y*mp*sin(theta) - Lc*g*mp*sin(theta))