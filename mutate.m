function g = mutate(g)

num_genes = length(g);

p_stiffen = 0.25;
p_nudge = 0.1;
p_toggle = 0.05/num_genes;
p_split = 0.25/num_genes;

weight_range = [0, 5];
weight_radius = 2;
k_choices = [0.5, 1, 2, 4];

nudge_radius = 3;

for i = 1:num_genes
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
        g{first.innovation} = first;
        g{second.innovation} = second;
    end
            
        
end

end