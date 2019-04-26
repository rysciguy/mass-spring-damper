classdef Genotype < handle
    properties
        num_points = 0;
        num_links = 0;
        num_genes = 0;
        genome = {}; %empty genome
    end
    methods
        function obj = Genotype(genome)
            if nargin == 1
                for i = 1:length(genome)
                    obj.addGene( genome{i} );
                end
            end
        end
        function addGene(obj, gene)
            obj.num_points = obj.num_points + 1;
            innovation = obj.incrementInnovation();
            gene.innovation = innovation;
            obj.genome{innovation} = gene;
            gene.genotype = obj;
        end
        function num_links = incrementLinks(obj)
            obj.num_links = obj.num_links + 1;
            num_links = obj.num_links;
        end
        function num_points = incrementPoints(obj)
            obj.num_points = obj.num_points + 1;
            num_points = obj.num_points;
        end
        function innovation = incrementInnovation(obj)
            obj.num_genes = obj.num_genes + 1;
            innovation = obj.num_genes;
        end
    end
end