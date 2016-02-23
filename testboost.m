function labels = testboost(testdata, features, signs, alpha)
    [n, foo] = size(testdata);
    D = 2 * testdata(:, features) - 1;
    labels = sign(sum(repmat(alpha', n, 1) .* repmat(signs', n, 1) .* D, 2));
