function h = plotStructure(obj, varargin)

%% Default options
ax = gca;
dimensions = obj.dimensions;
az = 15; %angle WRT -y axis
el = 15; %angle WRT +x axis

pos = [];
point_colors = [];

show_links = 1;
link_coords = [];
link_colors = [];
width_i = 0.5; %default LineWidth for links
ks = [];

% CHANGE_WIDTH = 0;
% width_min = 0.5;
% width_max = 3;

% limits = [-5 5 -5 5 -5 5];

%% Pass in options
%https://www.mathworks.com/help/matlab/creating_guis/initializing-a-guide-gui.html
if mod(nargin-1, 2) ~= 0
    error('Extra arguments must be in string, value pairs');
end
for index = 1:2:nargin-1
    if nargin-1==index, break, end
    switch lower(varargin{index}) %key
        case 'show_links'
            show_links = varargin{index+1};
        case 'dimensions'
            dimensions = varargin{index+1};
        case 'pos'
            pos = varargin{index+1};
        case 'limits'
            limits = varargin{index+1};
        case 'point_colors'
            point_colors = varargin{index+1};
        case 'link_coords'
            link_coords = varargin{index+1};
        case 'link_colors'
            link_colors = varargin{index+1};
        case 'ks'
            ks = varargin{index+1};
        case 'az'
            az = varargin{index+1};
        case 'el'
            el = varargin{index+1};
        case 'ax'
            ax = varargin{index+1};
    end
end

axes(ax);

%% Get Point coordinates and colors (if not already provided)
if isempty(pos)
    pos = transpose(reshape([obj.points.pos], 3, []));
%     n = obj.n;
%     pos = zeros(n, 3);
%     for i = 1:n
%         pos(i, :) = obj.points(i).pos;
%     end
end
if isempty(point_colors)
    point_colors = transpose(reshape([obj.points.color], 3, []));
end

%% Plot points
point_options = {'filled'};
if dimensions == 2
    s_plot = scatter(pos(:,1), pos(:,2), point_options{:});
elseif dimensions == 3
    s_plot = scatter3(pos(:,1), pos(:,2), pos(:,3), point_options{:});
end

s_plot.CData = point_colors;

%% Plot links (optional)
if show_links
    % Get Link coordinates and colors (if not already provided)
    if isempty(link_coords)
        [link_coords, link_colors] = obj.getLinkData(); 
    end
    num_links = size(link_coords, 3);
    if isempty(ks)
        ks = width_i*ones(num_links, 1);
    end
    for i = 1:num_links
        hold on;
        color = link_colors(i, :);
        link_options = {'k-', 'LineWidth', ks(i), 'Color', color};
        if dimensions == 2
            plot(link_coords(:,1,i), link_coords(:,2,i), link_options{:});
        elseif dimensions == 3
            plot3(link_coords(:,1,i), link_coords(:,2,i), link_coords(:,3,i), link_options{:});
        end
    end
end

% Maintain plot view settings
daspect([1,1,1]);
if exist('limits', 'var')
    axis(limits);
end
if dimensions == 3
    view(az, el);
end
hold off;

h = gcf;

end