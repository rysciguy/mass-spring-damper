function [max_displacement, mass] = evaluateBridgeFitness(structure, varargin)

%Defaults
PLOTTING = 1; %if True, plot the undeformed structure above the deformed structure
x_limits = [0, 10];
y_limits = [-5, 5];
limits = [x_limits y_limits];
num_plots = 1; %number of subplot columns
plot_ind = 1; %index of subplot column

%Arguments
for index = 1:2:nargin-1
    switch lower(varargin{index}) %key
        case 'plotting'
            PLOTTING = varargin{index+1};
        case 'limits'
            limits = varargin{index+1};
        case 'num_plots'
            num_plots = varargin{index+1};
        case 'plot_ind'
            plot_ind = varargin{index+1};
    end
end

% Parameters
unit_mass = 1; %mass per unit length
force = -0.25;
gravity = [0, 0, 0];

% Plot settings
dimensions = 2;
show_links = 1;

%% Build structure
s_0 = structure.getState(); %state vector
n = structure.countPoints();
[K, ~] = structure.getLinkMatrix(); %stiffness and damping matrices

% Boundary conditions
[structure.findPoints('left').DOF] = deal([0,0,0]); %fix left end
[structure.findPoints('right').DOF] = deal([0,0,0]); %fix right end

% Apply loads
% "Evenly distribute a total force of F=0.25 across all the point massses
% at the distal end (x=9) of the beam (there must be at least one point
% mass at the end of the beam)
loads = zeros(n, 3);
load_inds = [2]; %middle point
loads(load_inds, 2) = force/length(load_inds);
loads = loads + gravity;

% Preprocess links
[A_idxs, B_idxs, ks] = find(triu(K)); %indices of each pair of links
num_links = size(ks,1); %number of nonzero elements in K
[link_coords, link_colors] = structure.getLinkData();

% Calculate mass
L0 = zeros(num_links, 1);
for link_idx = 1:num_links
    L0(link_idx) = norm(link_coords(1, :, link_idx) - link_coords(2, :, link_idx));
end
mass = unit_mass*sum(L0);

% Plot undeformed structure
if PLOTTING
    subplot(2,num_plots,plot_ind);
    plot_args = {'link_coords', link_coords, 'link_colors', link_colors, 'limits', limits, ...
            'show_links', show_links};
    structure.plotStructure(plot_args{:});
end

%% Direct solver
% tic;
U = directStiffness(structure, K, loads); %displacement column vector
% toc;
max_displacement = max(abs(U));

%% Plot deformed structure
% Get position matrix
if PLOTTING

    U2 = reshape(U, dimensions, n)'; % nx2 array
    pos = zeros(n, 3);  
    for i = 1:n %convert state vector to position matrix
        pos(i, :) = s_0(getindex(i, 1:3, 0));
    end
    pos(:, 1:dimensions) = pos(:, 1:dimensions) + U2;

    % Get pairs of point coordinates for each link
    L = zeros(num_links, 1); %final length matrix
    if show_links
        for link_idx = 1:num_links
            link_coords(1,:,link_idx) = pos(A_idxs(link_idx),:);
            link_coords(2,:,link_idx) = pos(B_idxs(link_idx),:);
            L(link_idx) = norm(link_coords(1, :, link_idx) - link_coords(2, :, link_idx));
        end
    end
    
    % Calculate strain and color it
    Strain = (L-L0)./L0;
    strain_range = [min(Strain), max(Strain)];
    color_map = jet;
    color_range = 1:size(color_map, 1);
    strain_idxs = round(mapFromTo(Strain, strain_range, color_range));
    link_colors = color_map(strain_idxs, :);
    

    subplot(2,num_plots,plot_ind+num_plots);
    plot_args = {'pos', pos, 'link_coords', link_coords, 'link_colors', link_colors, 'limits', limits, ...
            'show_links', show_links};
    structure.plotStructure(plot_args{:});
    string = sprintf('m=%.1f, d=%.3e', mass, max_displacement);
    title(string);
end

end