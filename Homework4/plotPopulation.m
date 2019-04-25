function plotPopulation(chromosome, M, V)
% Plots the Pareto curve of the first non-dominated front and a sample of grid_size*grid_size solutions,
% including the two extrema

    % Parameters
    grid_x = 3;
    grid_y = 3;
    beam_height = 6;
    beam_length = 9;
    
    MASS = 1;
    DEFLECTION = 2;
    CROWDING = 3;
    sorting = DEFLECTION;
    
    % Pareto curve
    pareto_fig = figure;
    front = chromosome( chromosome(:, M+V+1)==1, : );
    front_size = size(front, 1);
    
    switch sorting
        case DEFLECTION
            [~, sort_index] = sortrows(front, V+1); %sort by deflection
            spacing = floor(front_size/(grid_x*grid_y - 2));
            sample = 2:spacing:front_size-1;
            sample = [1 sample front_size]; %somewhat "evenly" distributed
        case CROWDING
            [~, sort_index] = sortrows(front, size(front, 2)); %sort by crowding
            sort_index = sort_index(end:-1:1); %reverse
            sample = [1:grid_x*grid_y]; %get least crowded individuals
    end
    

    deflection = front(:, V+1);
    mass = front(:, V+2);
    
    title('Pareto curve');
    plot(deflection, mass,'*');
    xlabel('Deflection');
    ylabel('Mass');
    
    % Plot sample of solutions
    sample_fig = figure;
    
    for s = 1:length(sample)
        i = sort_index(sample(s));
        
        genome = chromosome(i, 1:V);
        
        matrix = genome2matrix(genome, beam_height, beam_length);
        structure = matrix2beam(matrix);
        
        subplot(grid_y, grid_x, s);
        structure.plotStructure();
        
        string = sprintf('%d (d=%.4f, m=%.1f)',...
            i, deflection(i), mass(i)); 
        title(string);
    end
    
    figure(pareto_fig);
    hold on; plot(deflection(sort_index(sample)), mass(sort_index(sample)), 'ro'); hold off;
end