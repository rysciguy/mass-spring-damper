function A = genome2matrix(genome, height, length)
    A = transpose(reshape(genome, length, height));
end