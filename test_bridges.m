% Script that plots and evaluates the fitness of a sample of manually
% generated Bridge structures

%% Settings
x_limits = [-1, 11];
y_limits = [-5, 5];
limits = [x_limits, y_limits];

%% Build bridge from genome
% genome0 = {Gene_Node([0, 0, 0]);
%             Gene_Node([5, 0, 0]);
%             Gene_Node([10, 0, 0]);
%             Gene_Connect(1, 2, 1);
%             Gene_Connect(2, 3, 1);
%             Gene_Nudge(2, [2,1,0]);
%             Gene_Split(1)
%             Gene_Nudge(4, [-1, -1, 0])};

        
genome = {Gene_Node([0, 0, 0]);
    Gene_Node([5, 0, 0]);
    Gene_Node([10, 0, 0]);
    Gene_Connect(1, 2, 1);
    Gene_Connect(2, 3, 1);
    Gene_Split(1);
    Gene_Nudge(4, [0, 5, 0]);
    Gene_Split(2);
    Gene_Nudge(5, [0, 5, 0]);
    Gene_Connect(4, 5, 1);
    Gene_Split(4);
    Gene_Split(7);
    Gene_Nudge(6, [-1.25, -2.5, 0]);
    Gene_Nudge(4, [-1.25, 0, 0]);
    Gene_Nudge(7, [-1.25, 0, 0]);
    Gene_Connect(7, 6, 1);
    Gene_Connect(7, 2, 1);
    Gene_Connect(6, 1, 1);
    Gene_Split(11);
    Gene_Split(5);
    Gene_Nudge(9, [1.25, -2.5, 0]);
    Gene_Nudge(8, [0.625, 0, 0]);
    Gene_Nudge(5, [1.25, 0, 0]);
    Gene_Connect(9, 3, 1);
    Gene_Connect(8, 9, 1);
    Gene_Connect(8, 2, 1);
    Gene_Split(16);
    Gene_Nudge(4, [0, -2.5, 0]);
    Gene_Nudge(5, [0, -2.5, 0]);
    Gene_Nudge(7, [0, -2.5, 0]);
    Gene_Nudge(8, [0, -2.5, 0])
    Gene_Connect(4, 8, 1)};

G = Genotype(genome);
        
sequences = {1:10;
             1:29;
             1:32};
% 
% sequences = {1:3;
%              1:8};
                
n = size(sequences, 1);
cols = 4;
rows = ceil(n/cols);
bridges = Bridge.empty(n, 0);
displacements = zeros(n, 1);
masses = zeros(n, 1);
for i = 1:n
    bridges(i) = Bridge(genome(sequences{i}));
    bridges(i).assemble();
    
    arguments = {'num_plots', n, 'plot_ind', i}; %used for subplots
    [d, m] = evaluateBridgeFitness(bridges(i), arguments{:});
    displacements(i) = d;
    masses(i) = d;
end