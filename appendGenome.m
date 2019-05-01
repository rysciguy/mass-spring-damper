function new_genome = appendGenome(genome, mutant)
    s_i = size(genome); %dimensions of current genome
    s_new = size(mutant);
    
    % Preallocate new_genome
    rows = s_i(1)+s_new(1);
    cols = max(s_i(2), s_new(2));
    new_genome = cell(rows, cols);
    
    new_genome(1:s_i(1), 1:s_i(2)) = genome;
    new_genome(s_i(1)+1:rows, 1:size(mutant,2)) = mutant;
end