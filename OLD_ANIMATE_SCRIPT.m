
%% Animate
% Spring animation
 %make figure pop out because animations don't work in Live Scripts
 
tic
 
fig_animation = figure('visible','on');
default_settings = {'XGrid', 'on', 'YGrid', 'on',...
                    'XLimMode', 'manual', 'YLimMode', 'manual', 'ZLimMode', 'manual'...
                    'xlim', x_limits,...
                    'ylim', y_limits};
axis 'manual';
set(gca, default_settings{:});

links = structure.getLinkMatrix;

gray = [0.25, 0.25, 0.25];

if dimensions == 2
    % Create mass circles; only Position will be updated in animation, reducing animation time by about 1/3
    for i = 1:N
        pos(i,:) = s_r( getindex(i, 1:3, 0) );
        mass(i) = rectangle('Position', [pos(1) - radius, pos(2) - radius, radius*2, radius*2],...
            'Curvature', [1,1],...
            'FaceColor', 'r');
        if structure.points(i).DOF == [0, 0, 0]
            set(mass(i), 'FaceColor', gray);
        end
    end
end

daspect([1,1,1]); % 1 unit on x axis should equal 1 unit on y axis, otherwise circles become elliptical
set(gca, default_settings{:}); %do again because plotting stuff changes things

% Set up for 3d plot
az = 120; %angle WRT -y axis
el = 30; %angle WRT +x axis
color_order = get(gca,'ColorOrder');

clear frames; %clean up in case there are leftover frames from previous run

% Loop to animate mass positions
i_loop = 1;
tic
for t_now = t_span(1):DELTA_T:t_span(2)
    i_cur = find( sol.x <= t_now, 1, 'last' ); %find index of nearest time to t_now
    if ~isempty(i_cur)
        t_cur = sol.x(i_cur); %exact simulation time
    end
    color_index = 1;
    for i = 1:N
        pos(i, :) = sol.y(getindex(i, 1:3, 0), i_cur);
        
        if dimensions == 2
            % Update mass positions
            set(mass(i), 'Position', [pos(i,1) - radius, pos(i,2) - radius, radius*2, radius*2]);
        elseif dimensions == 3
            if structure.points(i).DOF == [0, 0, 0]
                color = gray;
            else
                color = color_order(color_index, :);
                color_index = color_index + 1;
            end
            
            scatter3(pos(i,1), pos(i,2), pos(i,3), 'filled','MarkerFaceColor', color); hold on;
            axis([x_limits y_limits z_limits]);
            daspect([1,1,1]);
            view(az, el);
        end 
    end
    
    % Plot lines between points in 3D
    if dimensions == 3
       for i = 1:N
           for j = i:N
               if links(i, j) == 1
                   plot3(pos([i;j], 1), pos([i;j],2), pos([i;j], 3), 'k-');
               end
           end
       end
    end
    hold off;
        
    title(sprintf('t = %.2f', t_now)); %print time at top of figure
    drawnow;
    pause(delay); %used if animation is too quick to see
      
    if SAVE_VIDEO
        frames(i_loop) = getframe(gcf);
    end
    
    i_loop = i_loop + 1;
end


if SAVE_VIDEO
    v = VideoWriter(FILE_NAME);
    v.Quality = 90;
    open(v);
    writeVideo(v, frames); 
    close(v);
end
toc