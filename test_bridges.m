% Script that plots and evaluates the fitness of a sample of manually
% generated Bridge structures

%% Settings
x_limits = [-1, 11];
y_limits = [-5, 5];
limits = [x_limits, y_limits];

%% Build bridge from genome
genome = {Gene_Node([0, 0, 0]);
            Gene_Node([5, 0, 0]);
            Gene_Node([10, 0, 0]);
            Gene_Connect(1, 2, 1);
            Gene_Connect(2, 3, 1);
            Gene_Nudge(2, [2,1,0]);
            Gene_Split(1)
            Gene_Nudge(4, [-1, -1, 0])};
G = Genotype(genome);
        
% genome0 = {Gene_Node(1, [0, 0, 0]);
%     Gene_Node(2, [5, 0, 0]);
%     Gene_Node(3, [10, 0, 0]);
%     Gene_Connect(4, 1, 2, 1);
%     Gene_Connect(5, 2, 3, 1);
%     Gene_Split(6, 1);
%     Gene_Nudge(7, 4, [0, 5, 0]);
%     Gene_Split(8, 2);
%     Gene_Nudge(9, 5, [0, 5, 0]);
%     Gene_Connect(10, 4, 5, 1);
%     Gene_Split(11, 4);
%     Gene_Split(12, 7);
%     Gene_Nudge(13, 6, [-1.25, -2.5, 0]);
%     Gene_Nudge(14, 4, [-1.25, 0, 0]);
%     Gene_Nudge(15, 7, [-1.25, 0, 0]);
%     Gene_Connect(16, 7, 6, 1);
%     Gene_Connect(17, 7, 2, 1);
%     Gene_Connect(18, 6, 1, 1);
%     Gene_Split(19, 11);
%     Gene_Split(20, 5);
%     Gene_Nudge(21, 9, [1.25, -2.5, 0]);
%     Gene_Nudge(22, 8, [0.625, 0, 0]);
%     Gene_Nudge(23, 5, [1.25, 0, 0]);
%     Gene_Connect(24, 9, 3, 1);
%     Gene_Connect(25, 8, 9, 1);
%     Gene_Connect(26, 8, 2, 1);
%     Gene_Split(27, 16);
%     Gene_Nudge(28, 4, [0, -2.5, 0]);
%     Gene_Nudge(29, 5, [0, -2.5, 0]);
%     Gene_Nudge(30, 7, [0, -2.5, 0]);
%     Gene_Nudge(31, 8, [0, -2.5, 0])
%     Gene_Connect(32, 4, 8, 1)};
        
% sequences = {1:10;
%              1:29;
%              1:32};

sequences = {1:3;
             1:8};
                
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