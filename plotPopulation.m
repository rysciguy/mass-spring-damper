function plotPopulation(chromosome, M, V)
    % Parameters
    grid_size = 3;
    beam_height = 6;
    beam_length = 9;

    pop = size(chromosome, 1);
    
    % Pareto curve
    pareto_fig = figure;
    
    deflection = chromosome(:, V+1);
    mass = chromosome(:, V+2);
    
    title('Pareto curve');
    plot(deflection, mass,'*');
    xlabel('Deflection');
    ylabel('Mass');
    
    
    % Plot sample of solutions
    sample_fig = figure;
    sample = [2 : pop/(grid_size^2 - 2) : pop-1];
    sample = [1 sample pop];
    for p = 1:length(sample)
        i = sample(p);
        
        genome = chromosome(i, 1:V);
        
        matrix = genome2matrix(genome, beam_height, beam_length);
        structure = matrix2beam(matrix);
        
        subplot(grid_size, grid_size, p);
        structure.plotStructure();
        
        string = sprintf('Individual %d (deflection=%.3f, mass=%.1f)',...
            i, deflection(i), mass(i)); 
        title(string);
    end
    
    figure(pareto_fig);
    hold on; plot(mass(sample), deflection(sample), 'ro'); hold off;
end