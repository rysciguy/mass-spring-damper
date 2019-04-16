%% Set up
clear all; close all;

% Plot settings
dimensions = 2;
show_links = 1;
x_limits = [-10, 10];
y_limits = [-10, 10];
limits = [x_limits y_limits];

%% Build structure
stiffness = 200;
damping = 28;
matrix = [1,1,1,1,1;
          1,1,1,1,1;
          1,1,1,1,1]; %grid of point masses
structure = matrix2beam(matrix);
[structure.findPoints('left').DOF] = deal([0,0,0]); %fix left end
structure.refresh();
s_0 = structure.getState(); %state vector
n = structure.countPoints();
[K, B] = structure.getLinkMatrix(); %stiffness and damping matrices

% Apply loads
% "Evenly distribute a total force of F=0.25 across all the point massses
% at the distal end (x=9) of the beam (there must be at least one point
% mass at the end of the beam)
loads = zeros(n, 3);
[~, load_inds] = structure.findPoints('right');
loads(load_inds, 2) = 0.25/length(load_inds);
gravity = [0, 0, 0];
loads = loads + gravity;

% Preprocess
pos = zeros(n, 3);
[A_idxs, B_idxs, ks] = find(triu(K)); %indices of each pair of links
num_links = size(ks,1); %number of nonzero elements in K
[link_coords, link_colors] = structure.getLinkData();

%% Direct solver
tic;
U = directStiffness(structure, K, loads, dimensions); %displacement column vector
toc;
U2 = reshape(U, dimensions, n)'; % nx2 array

% Get position matrix
pos = zeros(n, 3);
for i = 1:n %convert state vector to position matrix
    pos(i, :) = s_0(getindex(i, 1:3, 0));
end
pos(:, 1:dimensions) = pos(:, 1:dimensions) + U2;

% Get pairs of point coordinates for each links
if show_links
    for l = 1:num_links
        link_coords(1,:,l) = pos(A_idxs(l),:);
        link_coords(2,:,l) = pos(B_idxs(l),:);
    end
end

% Plot
plot_args = {'pos', pos, 'link_coords', link_coords, 'link_colors', link_colors, 'limits', limits, ...
        'show_links', show_links};
structure.plotStructure(plot_args{:});