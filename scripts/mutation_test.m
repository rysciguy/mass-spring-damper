clear all; close all

stiffness = 1;
num_mutations = 5;

genome = {
Gene_Link(Gene.incrementPoints(), [0,0,0], Gene.incrementPoints(), [5,0,0], stiffness, 'A_static', 'B_static'),...
Gene_Link(2, [5,0,0], Gene.incrementPoints(), [10,0,0], stiffness, 'A_static', 'B_static'),...
Gene_Link(1, [0,0,0], Gene.incrementPoints(), [5,3,0], stiffness),...
Gene_Link(4, [5,3,0], 2, [5,0,0], stiffness),...
Gene_Link(4, [5,3,0], 3, [10,0,0], stiffness)
};

for i = 1:num_mutations
    mutant = mutate(genome(i,:));
    genome = appendMutant(genome, mutant);
end
f = testGenomes(genome, 'plotting', 0);


% g1 = genome(:,1);
% g2 = genome(:,8);
% [c1, c2] = crossover(g1,10,g2,2);
% figure;testGenomes([g1 g2 c1 c2]);