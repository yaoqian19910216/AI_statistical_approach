function condent = calculatescore(data, labels, ft)
    f = ft(1);
    t = ft(2);
    
    idx1 = find(data(:, f) <= t);
    idx2 = find(data(:, f) > t);
    
    p1 = length(idx1) / (length(idx1) + length(idx2));
    p2 = length(idx2) / (length(idx1) + length(idx2));
    
    ce1 = entr(labels(idx1));
    ce2 = entr(labels(idx2));
    
    condent = p1 * ce1 + p2 * ce2;
    