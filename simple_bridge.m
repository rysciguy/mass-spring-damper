%% Settings
x_limits = [-1, 11];
y_limits = [-5, 5];
limits = [x_limits, y_limits];

%% Manually build bridge
% bridge = Structure();
% bridge.dimensions = 2;
% left = Point([0, 0, 0]); left.DOF = [0, 0, 0];
% right = Point([10, 0, 0]); right.DOF = [0, 0, 0];
% middle = Point([5, 0, 0]);
% bridge.addPoint(left);
% left.parents = bridge;
% bridge.addPoint(right);
% right.parents = bridge;
% bridge.addPoint(middle);
% middle.parents = bridge;
% 
% link1 = left.connectTo(middle);
% bridge.links = [bridge.links link1];
% link2 = right.connectTo(middle);
% bridge.links = [bridge.links link2];

%% Build bridge from genome

genome = {Gene_Node(1, [0, 0, 0]);
            Gene_Node(2, [5, 0, 0]);
            Gene_Node(3, [10, 0, 0]);
            Gene_Connect(4, 1, 2, 1);
            Gene_Connect(5, 2, 3, 1);
            Gene_Nudge(6, 2, [2,1,0]);
            Gene_Split(7, 1)
            Gene_Nudge(8, 4, [-1, -1, 0])};
        
sequences = {1:5;
             1:6;
             1:7;
             1:8};
n = length(sequences);
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
% figure = gcf;
% for i = 1:n
%     subplot(rows, cols, i);
%     bridges(i).plotStructure('limits', limits, 'ax', gca);
%     title(mat2str(cell2mat(sequences(i))));
% end
%         
% figure;
% n = 3;
% 
% bridge1 = Bridge(genome(1:5));
% bridge1.assemble();
% 
% bridge2 = Bridge(genome(1:6));
% bridge2.assemble();
% 
% bridge3 = Bridge(genome(1:7));
% bridge3.assemble();
% 
% subplot(n,1,1);
% bridge1.plotStructure('limits', limits, 'ax', gca);
% subplot(n,1,2);
% bridge2.plotStructure('limits', limits, 'ax', gca);
% subplot(n,1,3);
% bridge3.plotStructure('limits', limits, 'ax', gca);