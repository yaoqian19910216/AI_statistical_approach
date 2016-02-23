function node = makenoderec(data, labels, idx)
    %%make a node out of these data points; check if it should be a leaf or not
    
    % Tree node data structure:
    % Fields: Idx (list of indices of data points in the node),
    %           isLeaf
    %           majorityLabel (if isLeaf is true)
    %           lChild (if isLeaf is false)
    %           rChild (if isLeaf is false)
    %           Feature, Threshold (if isLeaf is false)
    
    node = [];
    node.idx = idx;
    
    a = unique(labels(idx));
    if length(a) == 1
        %%then this is a pure node
        node.isLeaf = 1;
        node.majorityLabel = a(1);
    else
        node.isLeaf = 0;
    end
    
    %%%now deal with the very special case that all points in the node have
    %%%with exactly the same feature values but conflicting labels
    [C, ia, ic] = unique(data(idx, :),'rows');
    [nu, foo] = size(C);
    if (nu <= 1)
        node.isLeaf = 1;
        node.majorityLabel = mode(labels(idx, :));
    end
   
    if (node.isLeaf == 1)
        node.lChild = [];
        node.rChild = [];
        node.Feature = [];
        node.Threshold = [];
    else
        [f, t, s] = findsplittingrule(node, data, labels);
        node.Feature = f;
        node.Threshold = t;
            
        temp = find(data(:, f) <= t);
        idx1 = intersect(temp, node.idx);
        v1 = makenoderec(data, labels, idx1);
        node.lChild = v1;
    
        temp = find(data(:, f) > t);
        idx2 = intersect(temp, node.idx);
        v2 = makenoderec(data, labels, idx2);
        node.rChild = v2;
    end
    

    