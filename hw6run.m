a = load('hw6train.txt');
b = load('hw6test.txt');

[n , d] = size(a);
traindata = a(:, 1:d - 1);
trainlabels = a(:, d);

[m, d] = size(b);
testdata = b(:, 1:d - 1);
testlabels = b(:, d);

[features, signs, alpha, es] = boosting(traindata, trainlabels, 20);
for i = 1:20
    plabels = testboost(traindata, features(1:i), signs(1:i), alpha(1:i));
    trainerror = length(find(plabels ~= trainlabels))/n

    ptlabels = testboost(testdata, features(1:i), signs(1:i), alpha(1:i));
    testerror = length(find(ptlabels ~= testlabels))/m
end

