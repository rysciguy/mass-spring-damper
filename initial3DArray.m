length = 5;
height = 2;
width = 3;
a=1;

arguments = {'unit', a, ...
             'stiffness', 2000, ...
             'damping', 200, ...
             'density', 8};

gravity = [0, 0, -9.81];

structure = buildBeam(length, height, width, arguments{:});

% Fix left boundary
[structure.findPoints('left').DOF] = deal([0,0,0]);
structure.refresh();

% Alter middle layer
if orange
    z = 2;
    index = 1;
    centers = zeros(length*height, 3);
    for x = 1:length
        for y = 1:height
            centers(index, :) = [(x-1)*a, (y-1)*a, (z-1)*a];
            index = index + 1;
        end
    end
    middle = structure.getVoxel(centers);
    [middle.stiffness] = deal(150);
    [middle.damping] = deal(200);
    [middle.color] = deal([1,0.6,0]);
end
        
s_r = structure.getState();

% Initial conditions
% top_left = structure.getPoint(origin + [-a/2, a/2, 0]);
% top_left.pos = top_left.pos + [a, a, 0];

s_0 = structure.getState();

x_limits = [-a, a*(length+1)];
y_limits = [-2*a*height, a*(height+1)];
z_limits = [-a, a*(width+1)];
limits = [x_limits, y_limits, z_limits];

structure.refresh();
structure.plotStructure('limits', limits);