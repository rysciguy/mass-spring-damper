clear all;

stiffness = 1;
num_mutations = 5;

genome = {
Gene_Link(1, [0,0,0], 2, [5,0,0], stiffness, 'static');
Gene_Link(2, [5,0,0], 3, [10,0,0], stiffness, 'static');
Gene_Link(1, [0,0,0], 4, [5,3,0], stiffness);
Gene_Link(4, [5,3,0], 2, [5,0,0], stiffness);
Gene_Link(4, [5,3,0], 3, [10,0,0], stiffness);
};

for i = 1:num_mutations
    genome(:, i+1) = mutate2(genome(:,i));
end
testGenomes(genome);


% sequences = {
% 1:2;
% 1:5;
% };
% 
% testSequences(sequences, genome);