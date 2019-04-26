function mutation

%get genome
%randomly determine which gene to add
%depending on which gene chosen perform subfunctions to complete gene
%do not change node 1, 2 , or 3
%Gene:Node, Split, Connect, Nudge
%split: determine randomly which link to split
%nudge: determine randomly which pt to nudge, cannot be 1, 2, or 3
        %perform small nudge and then look at the "repulsion" of neighbors
        %change nudge pt so all "repulsions" of neighbors are equal
%add this new gene to genome



repf = 0;
ptnum = length(bridges.points); 
linknum = length(bridges.links); 
c = 10 %constant that converts repulsion force to a distance the pt moves



g=randi([1, 2]);
randlink = randi([1, linknum]);
randpt = randi([4, ptnum]);

if g == 1
   ng = Gene_Split(n, randlink);
   
elseif g == 2
    ng = Gene_Nudge(n, randpt, [randi([-10, 10])/10, randi([-10, 10])/10, 0]);
    
elseif g == 3
    ng = Gene_Connect();
    
elseif g == 4
    ng = Gene_Node();
    
end

if g == 2
    %acquire each pt's distance from this point
    %create "repulsion force" based off of this distance
    %sum repulsion forces and convert to some distance
    %check to make sure this distance is within the bounds
    %create new ng that equals new nudge
    origpt = bridges.points(1, randpt);
    for i = 1:ptnum   
    p = bridges.points(1,i).pos;
    dist = origpt - p;
    repf = repf + 1/(dist.^2);
    end
    ng = Gene_Nudge(n, randpt, repf/c);
    
end
