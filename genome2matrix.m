function A = genome2matrix(genome, length, height)
    A = transpose(reshape(genome, length, height));
end