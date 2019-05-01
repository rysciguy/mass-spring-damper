function plotPopulation(chromosome, genome, M)
% Plots the Pareto curve of the first non-dominated front and a sample of grid_size*grid_size solutions,
% including the two extrema

    % Parameters
    grid_x = 3;
    grid_y = 3;
    
    MASS = 1;
    DEFLECTION = 2;
    CROWDING = 3;
    sorting = DEFLECTION;
    
    % Pareto curve
    pareto_fig = figure;
    front = chromosome( chromosome(:, M+1)==1, : );
    front_size = size(front, 1);
    
    switch sorting
        case DEFLECTION
            [~, sort_index] = sortrows(front, 1); %sort by deflection
            spacing = floor(front_size/(grid_x*grid_y - 2));
            sample = randsample(front_size, grid_x*grid_y); %somewhat "evenly" distributed
        case CROWDING
            [~, sort_index] = sortrows(front, size(front, 2)); %sort by crowding
            sort_index = sort_index(end:-1:1); %reverse
            sample = [1:grid_x*grid_y]; %get least crowded individuals
    end
    

    deflection = front(:, 1);
    mass = front(:, 2);
    
    title('Pareto curve');
    plot(deflection, mass,'*');
    xlabel('Deflection');
    ylabel('Mass');
    
    % Plot sample of solutions
    sample_fig = figure;
    
    for s = 1:length(sample)
        i = sort_index(sample(s));
        
        bridge = Bridge(genome(i, :));
        bridge.assemble();
        
        subplot(grid_y, grid_x, s);
        bridge.plotBridge();
        
        string = sprintf('%d (d=%.4f, m=%.1f)',...
            i, deflection(i), mass(i)); 
        title(string);
    end
    
    figure(pareto_fig);
    hold on; plot(deflection(sort_index(sample)), mass(sort_index(sample)), 'ro'); hold off;
end