function g = mutate(g)

occupied = find(~cellfun('isempty', g));
num_genes = length(occupied);

% Mutations that operate on individual genes
p_stiffen = 0;
p_nudge = 0.25;
p_toggle = 0.0/num_genes;
p_split = 0.25/num_genes;
p_newnode = 0.25/num_genes;

k_choices = [0.5, 1, 2, 4];

nudge_radius = 3;

linked_ids = zeros(num_genes, 2); %prepopulate array for later
point_ids = [];

for i = occupied
    A_id = g{i}.A_id;
    B_id = g{i}.B_id;
    A_pos = g{i}.A_pos;
    B_pos = g{i}.B_pos;

    if rand()<p_stiffen
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
        angle = 2*pi*rand();
        nudge = rand()*nudge_radius*[cos(angle), sin(angle), 0];

        if rand()<0.5 && ~g{i}.A_static && ~isempty(g{i}.A_pos)
            g{i}.A_pos = g{i}.A_pos + nudge;
        elseif ~g{i}.B_static && ~isempty(g{i}.B_pos)
            g{i}.B_pos = g{i}.B_pos + nudge;
        end
    end
    if rand()<p_toggle
        g{i}.enabled = ~g{i}.enabled;
    end
    if rand()<p_split
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
    
    point_ids = unique([point_ids A_id B_id]);
       
end %for i = 1:num_genes

% Mutations that operate on the entire genome
dummy = Bridge(g);
dummy.assemble();
point_ids = [dummy.points.id];

p_connect = 0.8;
linked_ids = sort(linked_ids')';
num_points = length(point_ids);
if rand()<p_connect
    max_attempts = 5;
    attempt = 1;

    % Pick two random points and check whether than can be connected
    A = 0;
    B = 0;
    while A==B || ismember(sort([A,B]), linked_ids, 'rows')
        if attempt > max_attempts
            break
        end

        B = point_ids(randi(num_points));
        A = point_ids(randi(num_points));
        attempt = attempt + 1;
    end

    if attempt > max_attempts
    else
        pt_A = dummy.pointID(A);
        pt_B = dummy.pointID(B);
        A_pos = dummy.pointID(A).pos;
        B_pos = dummy.pointID(B).pos;

        new_stiffness = 1;
        new = Gene_Link(A, A_pos, B, B_pos, new_stiffness);
        g{new.innovation} = new;
    end
    
end

end