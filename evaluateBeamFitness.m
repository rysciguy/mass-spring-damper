function [max_displacement, mass] = evaluateBeamFitness(genome, beam_height, beam_length)

PLOTTING = 0;

matrix = genome2matrix(genome, beam_height, beam_length); %grid of point masses
if all(matrix(:, beam_length) == 0) %beam must have at least one point on its distal end
    max_displacement = Inf;
    mass = Inf;
    return
end

% Parameters
stiffness = 200;
unit_mass = 1; %mass per unit length
force = 0.25;
gravity = [0, 0, 0];

% Plot settings
dimensions = 2;
show_links = 1;
x_limits = [0, 10];
y_limits = [0, 10];
limits = [x_limits y_limits];

%% Build structure

structure = matrix2beam(matrix);

structure.stiffness = stiffness;
structure.refresh();

s_0 = structure.getState(); %state vector
n = structure.countPoints();
[K, ~] = structure.getLinkMatrix(); %stiffness and damping matrices

% Boundary conditions
[structure.findPoints('left').DOF] = deal([0,0,0]); %fix left end

% Apply loads
% "Evenly distribute a total force of F=0.25 across all the point massses
% at the distal end (x=9) of the beam (there must be at least one point
% mass at the end of the beam)
loads = zeros(n, 3);
[~, load_inds] = structure.findPoints('right');
loads(load_inds, 2) = force/length(load_inds);
loads = loads + gravity;

% Preprocess links
[A_idxs, B_idxs, ks] = find(triu(K)); %indices of each pair of links
num_links = size(ks,1); %number of nonzero elements in K
[link_coords, link_colors] = structure.getLinkData();

% Calculate mass
mass = 0;
for l_ind = 1:size(link_coords, 3)
    member_length = norm(link_coords(1, :, l_ind) - link_coords(2, :, l_ind));
    mass = mass + member_length*unit_mass;
end

% Plot
if PLOTTING
    subplot(2,1,1);
    plot_args = {'link_coords', link_coords, 'link_colors', link_colors, 'limits', limits, ...
            'show_links', show_links};
    structure.plotStructure(plot_args{:});
end

%% Direct solver
% tic;
U = directStiffness(structure, K, loads, dimensions); %displacement column vector
% toc;
max_displacement = max(abs(U));

%% Plot
% Get position matrix
if PLOTTING

    U2 = reshape(U, dimensions, n)'; % nx2 array
    pos = zeros(n, 3);  
    for i = 1:n %convert state vector to position matrix
        pos(i, :) = s_0(getindex(i, 1:3, 0));
    end
    pos(:, 1:dimensions) = pos(:, 1:dimensions) + U2;

    % Get pairs of point coordinates for each link
    if show_links
        for l = 1:num_links
            link_coords(1,:,l) = pos(A_idxs(l),:);
            link_coords(2,:,l) = pos(B_idxs(l),:);
        end
    end

    subplot(2,1,2);
    plot_args = {'pos', pos, 'link_coords', link_coords, 'link_colors', link_colors, 'limits', limits, ...
            'show_links', show_links};
    structure.plotStructure(plot_args{:});
end

end