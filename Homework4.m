%% Set up
clear all; close all;

% ODE settings
ode_options = odeset('MaxStep', 1); %set maximum step size to 1 second
t_span = [0 10]; %time span to be simulated

% Plot settings
DELTA_T = 0.1; %animation step size
delay = 0/1000; %(seconds) used to slow down animation in case it's too fast
radius = 0.4; %mass radius to be plotted (2D only)
show_links = 1;
x_limits = [-10, 10];
y_limits = [-10, 10];
limits = [x_limits y_limits];

% Video settings
SAVE_VIDEO = false; %if true, save animation frames to video
FILE_NAME = 'Plots/Test1b.avi';

%% Build structure
%initial 3DArray, initialBeam, initialCube, initialPart4, or initialSquare
initialBeam
n = structure.countPoints();
[K, B] = structure.getLinkMatrix();
% structure.plotStructure();

%% Solve equations of motion
tic
generateEqns(structure, gravity);
sol = ode23(@(t,x) autoODE(t,x), t_span, s_0, ode_options);
% sol = ode23(@(t,x) odefun(t, x, s_r, structure, K, B, gravity), t_span, s_0, ode_options);
toc
%% Animate
tic
fig_animation = figure('visible','on');

clear frames; %clean up in case there are leftover frames from previous run

% Preprocess
pos = zeros(n, 3);
[A_idxs, B_idxs, ks] = find(triu(K)); %indices of each pair of links
num_links = size(ks,1); %number of nonzero elements in K
[link_coords, link_colors] = structure.getLinkData();

% Loop to animate mass positions
i_loop = 1;
for t_now = t_span(1):DELTA_T:t_span(2)
    % Sync animation with solution state vector
    i_cur = find( sol.x <= t_now, 1, 'last' ); %find index of nearest time to t_now
    if ~isempty(i_cur)
        t_cur = sol.x(i_cur); %simulation time step
    end
    
    % Get point positions from state vector
    s = sol.y(:,i_cur); %state vector at current time step
    for i = 1:n %convert state vector to position matrix
        pos(i, :) = s(getindex(i, 1:3, 0));
    end
    
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
    
    % Animation stuff
    title(sprintf('t = %.2f', t_now)); %print time at top of figure
    drawnow;
    pause(delay); %used if animation is too quick to see
      
    if SAVE_VIDEO
        frames(i_loop) = getframe(gcf);
    end
    
    i_loop = i_loop + 1;
end
toc

%% Save video
if SAVE_VIDEO
    v = VideoWriter(FILE_NAME);
    v.Quality = 100;
    open(v);
    writeVideo(v, frames); 
    close(v);
end