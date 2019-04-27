classdef (Abstract) Gene < handle
    properties
        innovation; %innovation number
        enabled = 1;
        genotype;
    end
    
    methods (Abstract)
        express(obj, bridge);
    end
    
    methods (Static)
        function output = incrementLinks()
            persistent num_links
            if isempty(num_links)
                num_links=0;
            end
            num_links = num_links + 1;
            output = num_links;
        end
        function output = incrementPoints()
            persistent num_points
            if isempty(num_points)
                num_points=0;
            end
            num_points = num_points + 1;
            output = num_points;
        end
        function output = incrementInnovation()
            persistent num_genes
            if isempty(num_genes)
                num_genes=0;
            end
            num_genes = num_genes + 1;
            output = num_genes;
        end
    end
end