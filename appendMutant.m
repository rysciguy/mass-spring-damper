function new_genome = appendMutant(genome, mutant)
    size0 = size(genome);

    rows = size(mutant, 1);
    cols = size(genome, 2)+1;
    new_genome = cell(rows, cols);
    
    new_genome(1:size0(1), 1:size0(2)) = genome;
    new_genome(:, cols) = mutant;
end