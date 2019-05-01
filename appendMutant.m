function new_genome = appendMutant(genome, mutant)
    dim = size(genome); %dimensions of current genome

    % Preallocate new_genome
    rows = size(genome, 1)+1;
    cols = max(size(mutant, 2), size(genome, 2));
    new_genome = cell(rows, cols);
    
    new_genome(1:dim(1), 1:dim(2)) = genome;
    new_genome(rows, 1:size(mutant,2)) = mutant;
end