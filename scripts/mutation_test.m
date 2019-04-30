clear all;

stiffness = 1;
num_mutations = 8;

genome = {
Gene_Link(Gene.incrementPoints(), [0,0,0], Gene.incrementPoints(), [5,0,0], stiffness, 'A_static', 'B_static');
Gene_Link(2, [5,0,0], Gene.incrementPoints(), [10,0,0], stiffness, 'A_static', 'B_static');
Gene_Link(1, [0,0,0], Gene.incrementPoints(), [5,3,0], stiffness);
Gene_Link(4, [5,3,0], 2, [5,0,0], stiffness);
Gene_Link(4, [5,3,0], 3, [10,0,0], stiffness);
};

for i = 1:num_mutations
    mutant = mutate(genome(:,i));
    genome = appendMutant(genome, mutant);
end
testGenomes(genome);


% sequences = {
% 1:2;
% 1:5;
% };
% 
% testSequences(sequences, genome);