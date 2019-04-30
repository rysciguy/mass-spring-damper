function mutant = mutate(genome)

mutant = genome;

p_stiffen = 0.25;
p_nudge = 0.1;
p_toggle = 0.1;

weight_range = [0, 5];
weight_radius = 0.5;

nudge_radius = 1;

for i = 1:length(mutant)
    if rand()<p_stiffen
        old_stiffness = mutant{i}.stiffness;
        new_stiffness = old_stiffness + rand()*2*weight_radius-weight_radius;
        if new_stiffness < weight_range(1)
            new_stiffness = weight_range(1);
        elseif new_stiffness > weight_range(2)
            new_stiffness = weight_range(2);
        end
        mutant{i}.stiffness = new_stiffness;
    end
    if rand()<p_nudge
        if ~genome{i}.static
            angle = 2*pi*rand();
            nudge = rand()*nudge_radius*[cos(angle); sin(angle)];
                        
            if rand()<0.5
                genome{i}.A_pos = genome{i}.A_pos + nudge;
            else
                genome{i}.B_pos = genome{i}.B_pos + nudge;
            end
        end
    end
            
        
end

end