function [c1, c2] = crossover(p1, f1, p2, f2)
% Crosses over *sequences* (of gene numbers) 

    common = intersect(p1, p2);
    
    mask = rand(1, length(common)) < 0.5;
    c1(mask) = p1(mask);
    c1(~mask) = p2(~mask);

    c2(mask) = p1(mask);
    c2(~mask) = p2(~mask);
    
    if f1 > f2
        disjoint = setdiff(p1, p2); %in p1 but not p2
    else
        disjoint = setdiff(p2, p1); %in p2 but not p1
    end

    c1 = sort([c1, disjoint]);
    c2 = sort([c2, disjoint]);
    
end