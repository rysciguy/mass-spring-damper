% Script that plots manually generated Bridge structures

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
            Gene_Split(6, 1);
            Gene_Nudge(7, 4, [0, 5, 0]);
            Gene_Split(8, 2);
            Gene_Nudge(9, 5, [0, 5, 0]);
            Gene_Connect(10, 4, 5, 1);
            Gene_Split(11, 4);
            Gene_Split(12, 7);
            Gene_Nudge(13, 6, [-1.25, -2.5, 0]);
            Gene_Nudge(14, 4, [-1.25, 0, 0]);
            Gene_Nudge(15, 7, [-1.25, 0, 0]);
            Gene_Connect(16, 7, 6, 1);
            Gene_Connect(17, 7, 2, 1);
            Gene_Connect(18, 6, 1, 1);
            Gene_Split(19, 11);
            Gene_Split(20, 5);
            Gene_Nudge(21, 9, [1.25, -2.5, 0]);
            Gene_Nudge(22, 8, [0.625, 0, 0]);
            Gene_Nudge(23, 5, [1.25, 0, 0]);
            Gene_Connect(24, 9, 3, 1);
            Gene_Connect(25, 8, 9, 1);
            Gene_Connect(26, 8, 2, 1);
            Gene_Split(27, 16);
            Gene_Nudge(28, 4, [0, -2.5, 0]);
            Gene_Nudge(29, 5, [0, -2.5, 0]);
            Gene_Nudge(30, 7, [0, -2.5, 0]);
            Gene_Nudge(31, 8, [0, -2.5, 0])
            Gene_Connect(32, 4, 8, 1)};
        
sequences = {1:5;
             1:6;
             1:7;
             1:8;
             1:9;
             1:10;
             1:11;
             1:12;
             1:13;
             1:14;
%}
             1:15;
             1:16;
             1:17;
             1:18;
             1:19;
             1:20;
             1:21;
             1:22;
             1:23;
             1:24;
             1:25;
             1:26;
             1:27;
             1:28;
             1:29;
             1:30;
             1:31;
             1:32}; 
            % 1:33};
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