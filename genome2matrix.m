function A = genome2matrix(genome, beam_height, beam_length)
    A = transpose(reshape(genome, beam_length, beam_height));
end