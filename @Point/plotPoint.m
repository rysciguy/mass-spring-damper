function plotPoint(obj, varargin)
    % Default options
    show_links = 1;

    % Pass in options
    %https://www.mathworks.com/help/matlab/creating_guis/initializing-a-guide-gui.html
    if mod(nargin-1, 2) ~= 0
        error('Extra arguments must be in string, value pairs');
    end
    for index = 1:2:nargin-1
        if nargin-1==index, break, end
        switch lower(varargin{index}) %key
            case 'show_links'
                show_links = varargin{index+1};
        end

    end

    % Plot points
    n = countPoints(obj);
    pos = zeros(n, 3);
    for i = 1:n
        pos(i, :) = obj.points(i).pos;
    end
    scatter(pos(:,1), pos(:,2), 'filled');

    % Plot links (optional)
    if show_links
        links = obj.getLinks();
        for i = 1:length(links)
            coords = [links(i).A.pos; links(i).B.pos];
            hold on;
            plot(coords(:,1), coords(:,2), 'k-')
        end
    end
    daspect([1,1,1]);
end