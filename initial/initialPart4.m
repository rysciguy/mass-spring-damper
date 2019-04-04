% Three pixels in a row
a = 1;
dimensions = 2;
stiffness = 100;
damping = 50;
density = 4;

gravity = [0, -1, 0];

structure = buildBeam(3, 1, 0, 'stiffness', stiffness, 'damping', damping, 'density', 4);
s_r = structure.getState();

% Initial conditions
top_right = structure.findPoints('right', 'top');
top_right.pos = top_right.pos + [a/2, a/2, 0];

s_0 = structure.getState();

% Other conditions
left = structure.findPoints('left');
[left.DOF] = deal([0,0,0]);

pix2 = structure.getVoxel([1,0,0]);
pix2.damping = 25;
pix2.color = [1,0,0];

% Plotting
x_limits = [-a 4*a];
y_limits = [-2*a 2*a];
limits = [x_limits y_limits];

structure.refresh();
structure.plotStructure('limits', limits);