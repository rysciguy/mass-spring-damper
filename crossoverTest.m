% function crossoverTest(genome, idx1, f1, idx2, f2)
% g1 = genome(idx1,:);
% g2 = genome(idx2,:);
% [c1, c2] = crossover(g1,f1,g2,f2);
% figure;testGenomes([g1; g2; c1; c2]);
% end

clear all; close all;

% Arguments
x_limits = [-1, 2];
y_limits = [-1, 2];
limits = [x_limits y_limits];

arguments = {'limits', limits};

common = {Gene_Link(Gene.incrementPoints(),[0,0,0],Gene.incrementPoints(),[1,0,0],1),...
    Gene_Link(2, [1,0,0], Gene.incrementPoints(), [1,1,0], 1)};

% Square
g1 = {common{:} Gene_Link(1, [0,0,0], Gene.incrementPoints(), [0,1,0], 1),...
    Gene_Link(3, [1,1,0], 4, [0,1,0], 1)};

% Triangle
g2 = common;
g2{1,5} = Gene_Link(1, [0,0,0], 3, [1,1,0], 1);

g2{1}.stiffness = 4;
g2{2}.stiffness = 0.1;

f1 = 1;
f2 = 0;

[c1, c2] = crossover(g1, f1, g2, f2);

master = appendGenome(g1, g2);
master = appendGenome(master, c1);
master = appendGenome(master, c2);

figure; testGenomes(master, arguments{:});
