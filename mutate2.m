function mutant = mutate(original)

p_stiffen = 0.25;
p_nudgeA = 0.05;
p_nudgeB = 0.05;
p_toggle = 0.1;

weight_range = [0, 5];

for i = 1:length(original)
    g = original{i};
    
    p = rand();
    if p<p_stiffen
        old_stiffness = g.stiffness;
    end
            
            
        
end

end