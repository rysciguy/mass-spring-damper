dimensions = 3;
a = 1; %unit size

stiffness = 1;
damping = 0.2;
density = 4;

gravity = [0; 0; -9.81]/50; %[0, -9.81, 0]/10;

arguments = {'dimensions', dimensions, 'unit', a, 'stiffness', stiffness, 'damping', damping, 'density', density};

structure = buildBeam(3,3,3, arguments{:});
structure.refresh();
s_r = structure.getState();

% Boundary conditions
boundary_points = structure.findPoints('bottom');
[boundary_points.DOF] = deal([0, 0, 0]);

% Initial conditions
displaced_points = structure.findPoints('top');
for i = 1:length(displaced_points)
    displaced_points(i).pos = displaced_points(i).pos + [a,a,a]/5;
end

s_0 = structure.getState();

% Refresh
structure.refresh();

% Axis settings
ax_unit = a;
x_limits = [-2*ax_unit, 4*ax_unit];
y_limits = [-2*ax_unit, 4*ax_unit];
z_limits = [-2*ax_unit, 4*ax_unit];
limits = [x_limits, y_limits, z_limits];

% Plot
structure.plotStructure('limits', limits);