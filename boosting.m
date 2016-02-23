function [feature, signs, alpha, errors] = boosting(data, labels, rounds)
    %return the list of classifiers after #rounds of boosting
    %assumes data has 0/1 features, and labels are -1/1
    %also assumes there is a weak learning procedure given
    
    feature = [];
    signs = [];
    alpha = [];
    errors = [];
    
    [n, d] = size(data);
    D = (1.0/n) * ones(n, 1);
    
    for i = 1:rounds
        [f, s, e] = findweaklearner(data, labels, D);
        a = 0.5 * log( (1 - e)/e);
        weights = D .* exp( - s * a * labels .* (2 * data(:, f) - 1));
        D = weights / sum(weights);
        
        
        feature = [ feature; f];
        signs = [ signs; s];
        alpha = [alpha; a];
        errors = [errors; e];
    end
    
        
