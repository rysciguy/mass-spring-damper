a = 1;
dimensions = 2;
origin = [a/2, a/2, 0];
stiffness = 1;
damping = 2;
density = 4;

gravity = [0, 0, 0]; %[0, -9.81, 0]/10;

structure = Voxel('unit', a, 'dimensions', dimensions, 'origin', origin, 'stiffness', stiffness, 'damping', damping, 'density', 4);
s_r = structure.getState();

% Initial conditions
top_left = structure.findPoints('right', 'top');
top_left.pos = top_left.pos + [a/2, a/2, 0];

s_0 = structure.getState();

% Boundary conditions
bottom = structure.findPoints('bottom');
[bottom.DOF] = deal([0,0,0]);

% Plotting
x_limits = [-a 2*a];
y_limits = [-a/4 2*a];
limits = [x_limits y_limits];

structure.refresh();
structure.plotStructure('limits', limits);