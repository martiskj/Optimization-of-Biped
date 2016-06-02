function f = friction(Fy, mu, x, steepness)
    f = sigmoid(x, Fy*mu, steepness);
end