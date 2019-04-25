function A = genome2matrix(genome, beam_height, beam_length)
% Converts a linear array GENOME into a BEAM_HEIGHT by BEAM_LENGTH matrix
    A = transpose(reshape(genome, beam_length, beam_height));
end