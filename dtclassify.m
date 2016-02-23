function testlabel = dtclassify(root, testdata)
    if root.isLeaf == 1
        testlabel = root.majorityLabel;
    else 
        if testdata(root.Feature) <= root.Threshold
            testlabel = dtclassify(root.lChild, testdata);
        else
            testlabel = dtclassify(root.rChild, testdata);
        end
    end
    