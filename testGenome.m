function testGenomes(genome)
    n = size(genome, 2);
    bridges = Bridge.empty(n, 0);
    displacements = zeros(n, 1);
    masses = zeros(n, 1);
    for i = 1:n
        bridges(i) = Bridge(genome{:, i});
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