function e = entr(v)
    %%calculate the entropy of a vector
    
    a = unique(v);
    freqdist = zeros(length(a), 1);
    
    for i = 1:length(a)
        freqdist(i) = sum(v == a(i)) / length(v);
    end
    e = 0;
    for i = 1:length(a)
        e = e - freqdist(i) * log(freqdist(i));
    end
    