function new_genome = appendMutant(genome, mutant)
    dim = size(genome);

    rows = size(genome, 1)+1;
    cols = size(mutant, 2);
    new_genome = cell(rows, cols);
    
    new_genome(1:dim(1), 1:dim(2)) = genome;
    new_genome(rows, :) = mutant;
end