%function mutation

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
%ng is just a place holder for now



repf = 0;
ptnum = length(bridges.points); 
linknum = length(bridges.links); 
c = 10; %constant that converts repulsion force to a distance the pt moves



g=randi([1, 2]);
randlink = randi([1, linknum]);
randpt = randi([4, ptnum]);

if g == 1
   ng = Gene_Split(n, randlink);
   
elseif g == 2
    %ng = Gene_Nudge(n, randpt, [randi([-10, 10])/10, randi([-10, 10])/10, 0]);
    nudge = bridges.points(1,randpt).pos + [randi([-10, 10])/10, randi([-10, 10])/10, 0];
    
elseif g == 3
    ptA = randi([1, ptnum]);
    ptB = randi([1, ptnum]);
    for ptA = ptB
        ptB = randi([1, ptnum]);
    end
    ng = Gene_Connect(n, ptA, ptB, 1);
    
elseif g == 4
    ng = Gene_Node(n, [rand.*10, -5+(5+5).*rand, 0]); %change so it matches the x,y lims
    
elseif g == 5
    %change link stiffness
    bridges.links(randi([1,linknum]),1).stiffness = rand*7;
end

if g == 2
    %acquire each pt's distance from this point
    %create "repulsion force" based off of this distance
    %sum repulsion forces and convert to some distance
    %check to make sure this distance is within the bounds
    %create new ng that equals new nudge
    origpt = bridges.points(1, randpt).pos;
    for i = 1:ptnum   
    p = bridges.points(1,i).pos;
    dist = origpt + nudge - p;
    s = dist.^-2;
    s(1,3) = 0;
    repf = repf + s;
    end
    repdist = repf/c;
    check = repdist + origpt;
    
    %change these limits to call to x,y limits
    if check(1,1) > 10 
        repdist(1,1) = 10 - origpt(1,1);
    end
    if check(1,2) > 5
        repdist(1,2) = 5 - origpt(1,2);
    end
    if check(1,1) < 0
        repdist(1,1) = 0 - origpt(1,1);
    end
    if check(1,2) < -5
        repdist(1,2) = -5 - orgipt(1,2);
    end
    
    ng = Gene_Nudge(n, randpt, repdist); %change
    
end
%end
