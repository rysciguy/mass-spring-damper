function [c1, c2] = crossover(g1, f1, g2, f2)
% Crosses over genomes g1 and g2 to produce two children c1 and c2
    
    child_length = max( size(g1,1), size(g2,1) );
    c1 = cell(child_length, 1);
    c2 = c1;
    
    p1 = find(~cellfun('isempty', g1)); %indices where genome g1 has genes
    p2 = find(~cellfun('isempty', g2));

    common = intersect(p1, p2);
    mask = rand(1, length(common)) < 0.5;
    
    from1 = common(mask);
    from2 = common(~mask);
    
    c1(from1) = g1(from1);
    c1(from2) = g2(from2);
    
    c2(from2) = g1(from2);
    c2(from1) = g2(from1);
    
     
%     c1(mask) = p1(mask);
%     c1(~mask) = p2(~mask);
% 
%     c2(mask) = p1(mask);
%     c2(~mask) = p2(~mask);
    
    if f1 > f2
        disjoint_idxs = setdiff(p1, p2); %in p1 but not p2
        disjoint = g1(disjoint_idxs);
    else
        disjoint_idxs = setdiff(p2, p1); %in p2 but not p1
        disjoint = g2(disjoint_idxs);
    end

    c1(disjoint_idxs) = disjoint;
    c2(disjoint_idxs) = disjoint;    
end