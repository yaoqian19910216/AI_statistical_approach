function  root = ID3DecisionTreeRec(data, labels)
    %%creates an ID3 decision tree based on the labelled data
    
    % Tree node data structure:
    % Fields: Idx (list of indices of data points in the node),
    %           isLeaf
    %           majorityLabel (if isLeaf is true)
    %           lChild (if isLeaf is false)
    %           rChild (if isLeaf is false)
    %           Feature, Threshold (if isLeaf is false)
    
    [n, d] = size(data);
    idx = 1:n;
    root = makenoderec(data, labels, idx);     %%make a node out of these data points; check if it should be a leaf or not
    
    
    
            
    