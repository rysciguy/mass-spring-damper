classdef Bridge < Structure
% BRIDGE objects are 2-dimensional evolutionary structures
    properties
        genome;
        fitness;
    end
    methods
        function obj = Bridge(genome) 
            % Constructor
            obj.dimensions = 2; 
            obj.color = [0,0,0]; %black
            obj.genome = genome;
        end
        
        function assemble(obj)
            for i = 1:length(obj.genome)
                g = obj.genome{i};
                g.express(obj);
            end
           % obj.refresh();
        end
    end
end