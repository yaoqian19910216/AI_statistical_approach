
atrain = load('hw3train.txt');
atest = load('hw3test.txt');

trdata = atrain(:, 1:4);
trlabels = atrain(:, 5);

tdata = atest(:, 1:4);
tlabels = atest(:, 5);

root = ID3DecisionTreeRec(trdata, trlabels);

terror = 0;
for i = 1:50
    lab = dtclassify(root, tdata(i, :));
    if lab ~= tlabels(i)
        terror = terror + 1.0/50;
    end
end
terror

