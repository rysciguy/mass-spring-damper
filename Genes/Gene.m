classdef (Abstract) Gene
    properties
        innovation; %innovation number
        enabled = 1;
    end
    
    methods (Abstract)
        express(obj, bridge);
    end
    
    methods (Static)
        function output = incrementLinks(n)
            persistent num_links
            if isempty(num_links)
                num_links=0;
            end
            
            if nargin==0
                n = 1;
            end
            
            num_links = num_links + n;
            output = num_links;
        end
        function output = incrementPoints(n)
            persistent num_points
            if isempty(num_points)
                num_points=0;
            end
            
            if nargin==0
                n = 1;
            end
            
            num_points = num_points + n;
            output = num_points;
        end
        function output = incrementInnovation(n)
            persistent num_genes
            if isempty(num_genes)
                num_genes=0;
            end
            
            if nargin==0
                n = 1;
            end
            
            num_genes = num_genes + n;
            output = num_genes;
        end
    end
end