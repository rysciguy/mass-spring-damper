function crossoverTest(genome, idx1, f1, idx2, f2)
g1 = genome(idx1,:);
g2 = genome(idx2,:);
[c1, c2] = crossover(g1,f1,g2,f2);
figure;testGenomes([g1; g2; c1; c2]);
end