function plotBridge(obj)
% Parameters
x_limits = [0, 10];
y_limits = [-5, 5];
limits = [x_limits y_limits];
show_links = 1;

% Preprocess links
[K, ~] = obj.getLinkMatrix(); %stiffness and damping matrices
[~, ~, ks] = find(triu(K)); %indices of each pair of links
% num_links = size(ks,1); %number of nonzero elements in K
[link_coords, link_colors] = obj.getLinkData();


plot_args = {'link_coords', link_coords, 'link_colors', link_colors, 'limits', limits, ...
            'show_links', show_links, 'ks', ks};
obj.plotStructure(plot_args{:});

end