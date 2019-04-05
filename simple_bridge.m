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
            Gene_Connect(5, 2, 3, 1)};

bridge = Bridge(genome);
bridge.assemble();

bridge.plotStructure('limits', limits);