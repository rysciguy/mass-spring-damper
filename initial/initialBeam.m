length = 5;
height = 3;
width = 0;
a=1;

arguments = {'unit', a, ...
             'stiffness', 100, ...
             'damping', 50, ...
             'density', 4};

gravity = [0, -9.81, 0]/10;

structure = buildBeam(length, height, width, arguments{:});
structure.refresh();
s_r = structure.getState();

% Initial conditions
% top_left = structure.getPoint(origin + [-a/2, a/2, 0]);
% top_left.pos = top_left.pos + [a, a, 0];

s_0 = structure.getState();

x_limits = [-a, a*(length+1)];
y_limits = [-2*a*height, a*(height+1)];

