function [indices, coeff] = trainkernelperc(kernelmat, label, passes)
    %train a kernel perceptron algorithm given a pre-computed kernel matrix
    %on the data points
    %returns a list of indices of the data points involved in the
    %perceptron classifier along with their coefficients
    
    [n, foo] = size(kernelmat);
    indices = [];
    coeff = [];
    
    for i = 1:passes
        for j = 1:n
            if (size(coeff, 1) == 0 || label(j) * sum(int32(kernelmat(indices, j)) .* coeff) <= 0)
                indices = [ indices; j ];
                coeff = [ coeff; label(j) ];
            end
        end
    end
    