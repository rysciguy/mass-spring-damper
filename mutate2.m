function g = mutate2(g)

p_stiffen = 0.25;
p_nudge = 0.1;
p_toggle = 0.05;
p_split = 0.5;

weight_range = [0, 5];
weight_radius = 0.5;

nudge_radius = 3;

num_genes = length(g);

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
        C_id = Gene.incrementPoints();
        
        first = Gene_Link(A_id, A_pos, C_id, C_pos, new_stiffness);
        second = Gene_Link(C_id, C_pos, B_id, B_pos, new_stiffness);
        g{length(g)+1} = first;
        g{length(g)+1} = second;
    end
            
        
end

end