function y = sigmoid(x, amplitude, steepness)
    y = amplitude*2./(1.0 + exp(-steepness*x)) - amplitude;
end