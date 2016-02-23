%%%%%Code for HW5
fid = fopen('hw5train.txt');
tr = textscan(fid, '%s %d');
fclose(fid);

fid = fopen('hw5test.txt');
ts = textscan(fid, '%s %d');
fclose(fid);

[trainsize, foo] = size(tr{1});
[testsize, foo] = size(ts{1});

for i = 1:trainsize
    tdata{i} = tr{1}{i};
    tlabels(i) = tr{2}(i,1);
end

for i = 1:testsize
    sdata{i} = ts{1}{i};
    slabels(i) = ts{2}(i,1);
end

p = 4
kmat = computestringkernelmat(tdata, tdata, p);
[indices, coeff] = trainkernelperc(kmat, tlabels, 1);
    
kcrossmat = computestringkernelmat(tdata, sdata, p);

predlabels = sign(sum(int32(kmat(indices, :)) .* int32(repmat(coeff, 1, trainsize)), 1));
percmistakes = length(find(int32(predlabels) ~= tlabels))
trainerror = percmistakes/trainsize

predlabels = sign(sum(int32(kcrossmat(indices, :)) .* int32(repmat(coeff, 1, testsize)), 1));
percmistakes = length(find(int32(predlabels) ~= slabels))
testrror = percmistakes/testsize