dimensions = 3;
a = 2; %unit size
origin = [a/2, a/2, a/2];

stiffness = 1;
damping = 1;
density = 4;

gravity = [0; 0; -9.81]/50; %[0, -9.81, 0]/10;

arguments = {'origin', origin, 'dimensions', dimensions, 'unit', a, 'stiffness', stiffness, 'damping', damping, 'density', density};

structure = Voxel(arguments{:});
structure.refresh();
s_r = structure.getState();

% Boundary conditions
boundary_points = structure.findPoints('bottom');
[boundary_points.DOF] = deal([0, 0, 0]);

% Initial conditions
displaced_point = structure.findPoints('top', 'right', 'back');
displaced_point.pos = displaced_point.pos + [a/2, a/2, 0];

s_0 = structure.getState();

% Refresh
structure.refresh();

% Axis settings
ax_unit = a;
x_limits = [-ax_unit, 2*ax_unit];
y_limits = [-ax_unit, 2*ax_unit];
z_limits = [-ax_unit, 2*ax_unit];
limits = [x_limits, y_limits, z_limits];

% Plot
structure.plotStructure('limits', limits);