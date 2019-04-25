classdef Genotype < handle
    properties
        num_points = 0;
        num_links = 0;
        num_genes = 0;
        chromosome = {}; %empty genome
    end
    methods
        function addGene(obj, gene)
            obj.num_points = obj.num_points + 1;
            obj.chromosome{obj.num_points} = gene;
        end
    end
end