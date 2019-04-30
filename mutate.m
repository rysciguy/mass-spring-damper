function g = mutate(g)

num_genes = length(g);

p_stiffen = 0.25;
p_nudge = 0.1;
p_toggle = 0/num_genes;
p_split = 0/num_genes; %0.25
p_newnode = 0.25/num_genes;

weight_range = [0, 5];
weight_radius = 2;

nudge_radius = 3;

for i = 1:num_genes
    if rand()<p_stiffen
        old_stiffness = g{i}.stiffness;
        new_stiffness = old_stiffness + rand()*2*weight_radius-weight_radius;
        if new_stiffness < weight_range(1)
            new_stiffness = weight_range(1);
        elseif new_stiffness > weight_range(2)
            new_stiffness = weight_range(2);
        end
        g{i}.stiffness = new_stiffness;
    end
    if rand()<p_nudge
        angle = 2*pi*rand();
        nudge = rand()*nudge_radius*[cos(angle), sin(angle), 0];

        if rand()<0.5 && ~g{i}.A_static
            g{i}.A_pos = g{i}.A_pos + nudge;
        elseif ~g{i}.B_static
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
        
        A_pos = g{i}.A_pos; A_id = g{i}.A_id;
        B_pos = g{i}.B_pos; B_id = g{i}.B_id;
        
        C_pos = A_pos + (B_pos-A_pos)/2;
        C_id = g{i}.incrementPoints();
        
        first = Gene_Link(A_id, A_pos, C_id, C_pos, new_stiffness);
        second = Gene_Link(B_id, B_pos, C_id, C_pos, new_stiffness);
        g{length(g)+1} = first;
        g{length(g)+1} = second;
    end
    if rand()<p_newnode
        %g{i}.enabled = false;
        old_stiffness = g{i}.stiffness;
        new_stiffness = old_stiffness; %may change later
        
        A_pos = g{i}.A_pos; A_id = g{i}.A_id;
        B_pos = g{i}.B_pos; B_id = g{i}.B_id;
        
        C_pos_i = A_pos + (B_pos-A_pos)/2;
        i_nudge = C_pos_i + [randi([-10, 10])/10, randi([-10, 10])/10, 0];
        dist_A = i_nudge - A_pos;
        dist_B = i_nudge - B_pos;
        repf = ((norm(dist_A)).^-2).*(dist_A/norm(dist_A)) + ((norm(dist_B)).^-2).*(dist_B/norm(dist_B));
        C_pos = ((repf)*1)+i_nudge;
        C_id = g{i}.incrementPoints();
        
        first = Gene_Link(A_id, A_pos, C_id, C_pos, new_stiffness);
        second = Gene_Link(B_id, B_pos, C_id, C_pos, new_stiffness);
        g{length(g)+1} = first;
        g{length(g)+1} = second; 
        disp('Newnode Mutate')
    end
            
        
end

end