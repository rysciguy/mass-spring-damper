function g = mutate(g)

occupied = find(~cellfun('isempty', g)); %indices of cells in the cell array which are not empty
num_genes = length(occupied);

% Mutations that operate on individual genes
p_stiffen = 0.25;
p_nudge = 0.25;
p_toggle = 0.0/num_genes;
p_split = 0.25/num_genes;
p_newnode = 0.25/num_genes;

k_choices = [0.5, 1, 2, 4]; %possible stiffness values

nudge_radius = 3; %maximum nudge distance

linked_ids = zeros(0, 2); %array tracking the IDs of all link endpoints

for i = occupied
    A_id = g{i}.A_id;
    B_id = g{i}.B_id;
    A_pos = g{i}.A_pos;
    B_pos = g{i}.B_pos;

    if rand()<p_stiffen
        % Select a stiffness value from an array of choices
        old_stiffness = g{i}.stiffness;
%         index = find(old_stiffness == k_choices);
        new_stiffness = k_choices(randi(length(k_choices)));
        
%         new_stiffness = old_stiffness + rand()*2*weight_radius-weight_radius;
%         if new_stiffness < weight_range(1)
%             new_stiffness = weight_range(1);
%         elseif new_stiffness > weight_range(2)
%             new_stiffness = weight_range(2);
%         end
        g{i}.stiffness = new_stiffness;
    end
    if rand()<p_nudge
        % Nudge one point by some amount in a random direction. Static
        % points are exempt from nudges.
        angle = 2*pi*rand();
        nudge = rand()*nudge_radius*[cos(angle), sin(angle), 0];

        if rand()<0.5 && ~g{i}.A_static && ~isempty(g{i}.A_pos)
            g{i}.A_pos = g{i}.A_pos + nudge;
        elseif ~g{i}.B_static && ~isempty(g{i}.B_pos)
            g{i}.B_pos = g{i}.B_pos + nudge;
        end
    end
    if rand()<p_toggle
        % Toggle the gene on or off
        g{i}.enabled = ~g{i}.enabled;
    end
    if rand()<p_split
        % Disable existing gene and add two new genes connecting the
        % endpoints to the midpoint
        
        g{i}.enabled = false;
        old_stiffness = g{i}.stiffness;
        new_stiffness = old_stiffness; %may change later
        
        C_pos = A_pos + (B_pos-A_pos)/2;
        C_id = g{i}.incrementPoints();
        
        first = Gene_Link(A_id, A_pos, C_id, C_pos, new_stiffness);
        second = Gene_Link(B_id, B_pos, C_id, C_pos, new_stiffness);
        g{first.innovation} = first;
        g{second.innovation} = second;
    end
    if rand()<p_newnode
        old_stiffness = g{i}.stiffness;
        new_stiffness = old_stiffness; %may change later
        
        C_pos_i = A_pos + (B_pos-A_pos)/2;
        i_nudge = C_pos_i + [randi([-10, 10])/10, randi([-10, 10])/10, 0];
        dist_A = i_nudge - A_pos;
        dist_B = i_nudge - B_pos;
        repf = ((norm(dist_A)).^-2).*(dist_A/norm(dist_A)) + ((norm(dist_B)).^-2).*(dist_B/norm(dist_B));
        C_pos = ((repf)*(15/num_genes))+i_nudge;
        C_id = g{i}.incrementPoints();
        
        first = Gene_Link(A_id, A_pos, C_id, C_pos, new_stiffness);
        second = Gene_Link(B_id, B_pos, C_id, C_pos, new_stiffness);
        g{first.innovation} = first;
        g{second.innovation} = second; 
    end
    
    if g{i}.enabled
        linked_ids(i, 1) = A_id;
        linked_ids(i, 2) = B_id;
    end
       
end %for i = 1:num_genes

% Mutations that operate on the entire genome
dummy = Bridge(g);
dummy.assemble();
point_ids = [dummy.points.id];
As = [dummy.links.A];
Bs = [dummy.links.B];
linked_ids = [[As.id]', [Bs.id]']; %lowest id in first column

p_connect = 0.8;
% linked_ids = sort(linked_ids')';
num_points = length(point_ids);
if rand()<p_connect
    % Pick two random points and check whether they can be connected
    A_id = point_ids(randi(num_points));
    [rows, cols] = find(linked_ids == A_id);
    num_neighbors = length(rows);
    if num_neighbors >= num_points-1
        % stop
    else
        neighbors = zeros(num_neighbors, 0);
        for idx = 1:num_neighbors
            i = rows(idx);
            j = 1 + (cols(idx) == 1); %if A_id is in column 1, neighbor is in column 2
            neighbors(idx) = linked_ids(i, j);
        end
        choices = setdiff(point_ids, [neighbors A_id]);
        num_choices = length(choices);
        
        % Point A
        pt_A = dummy.pointID(A_id);
        A_pos = pt_A.pos;
        
        % Get nearest point to Point A among choices
        choice_pts = Point.empty(num_choices, 0);
        choice_poses = zeros(num_choices, 3);
        distances = zeros(num_choices, 1);
        for i = 1:num_choices
            choice_pts(i) = dummy.pointID(choices(i));
            choice_poses(i, :) = choice_pts(i).pos;
            distances(i) = norm(A_pos - choice_poses(i,:));
        end
%         distances = norm(A_pos - choice_poses);
        [~, sorting] = sort(distances);
        
        B_id = choices(sorting(1));
%         B_id = choices( randi(length(choices)) );

        pt_B = dummy.pointID(B_id);
        B_pos = pt_B.pos;

        new_stiffness = 1;
        new = Gene_Link(A_id, A_pos, B_id, B_pos, new_stiffness);
        g{new.innovation} = new;
    end
    
end

end