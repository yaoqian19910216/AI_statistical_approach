function [feat, thres, s] = findsplittingrule(node, data, labels)
    %%Given a node which is not a leaf, find a splitting rule for splitting
    %%it into a left and a right child
    
 %first set up a feasible set of (feature, threshold) pairs list
 [n, d] = size(data);
 
 ftlist = [];
 for i = 1:d
     a = unique(data(node.idx, i));
     if length(a) > 1
         for j = 1:length(a) - 1
             ftlist = [ [i, 0.5 * (a(j) + a(j+1))]; ftlist];
         end
     end
 end
 
 %%length of ftlist has to be at least 1, otherwise, we could have caught
 %%and dealt with it at makenode
 [m, foo] = size(ftlist);
 scores = zeros(m, 1);
 
 for i = 1:m
     scores(i, 1) = calculatescore(data(node.idx, :), labels(node.idx), ftlist(i, :));
 end
 [s, j] = min(scores);
 feat = ftlist(j, 1);
 thres = ftlist(j, 2);
 
     
