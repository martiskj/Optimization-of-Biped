syms amplitude steepness x mu F_y;
s = amplitude*2./(1.0 + exp(-steepness*x)) - amplitude;

ds = fulldiff(s, x);
d2s = fulldiff(ds, x);
d3s = fulldiff(d2s, x);

eqn1 = d3s == 0;
eqn2 = x == mu*F_y;
eqn3 = amplitude == mu*F_y;

steepness = solve([eqn1, eqn2, eqn3], [steepness, x, amplitude])