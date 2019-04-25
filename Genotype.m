classdef Genotype < handle
    properties
        num_points = 0;
        num_links = 0;
        num_genes = 0;
        genome = {}; %empty genome
    end
    methods
        function addGene(obj, gene)
            obj.num_points = obj.num_points + 1;
            obj.genome{obj.num_points} = gene;
        end
        function num_links = incrementLinks(obj)
            obj.num_links = obj.num_links + 1;
            num_links = obj.num_links;
        end
        function num_points = incrementPoints(obj)
            obj.num_points = obj.num_points + 1;
            num_points = obj.num_points;
        end
    end
end