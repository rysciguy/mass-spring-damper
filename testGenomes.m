function testGenomes(genomes)
% Evaluates n genomes in a x by n cell array genomes, where x is a variable
% number of genes in each genome

    n = size(genomes, 1);
    bridges = Bridge.empty(n, 0);
    displacements = zeros(n, 1);
    masses = zeros(n, 1);
    for i = 1:n
        bridges(i) = Bridge(genomes(i,:));
        bridges(i).assemble();

        arguments = {'num_plots', n, 'plot_ind', i}; %used for subplots
        [d, m] = evaluateBridgeFitness(bridges(i), arguments{:});
        displacements(i) = d;
        masses(i) = m;
    end


%     bridge = Bridge(genome);
%     bridge.assemble();
%     [d, m] = evaluateBridgeFitness(bridge);
end