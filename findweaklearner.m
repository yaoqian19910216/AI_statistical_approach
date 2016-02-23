function [feature, signs, e] = findweaklearner(data, labels, W)
    [n, d] = size(data);
    
    indicators = ((2 * data - 1) ~= repmat(labels, 1, d));
    windicators = repmat(W, 1, d) .* indicators;
    errors = sum(windicators, 1);
    
    e1 = min(0.5, min(errors));
    e2 = 1 - max(0.5, max(errors));
    
    if (e1 == 0.5 & e2 == 0.5)
        %%no weak learner! very rare case
        disp('No weak learner\n');
    end
    
    if (e1 < e2)
        feature = find(errors == e1);
        if (length(feature) > 1)
            disp('Ties in selecting features\n');
            feature = feature(1);
        end
        signs = 1;
        e = e1;
    else if (e2 < e1)
            feature = find(errors == 1 - e2);
            if (length(feature) > 1)
                disp('Ties in selecting features\n');
                feature = feature(1);
            end
            signs = -1;
            e = e2;
        else %%e1 and e2 are exactly equal
            disp('Ties in selecting features -- positive and negative ties\n');
            feature = find(errors == e1);
            feature = feature(1);
            signs = 1;
            e = e1;
        end
    end
    
            
    
    
