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
%             obj.refresh();
        end
        
        function point = pointID(obj, id)
            id_list = [obj.points.id];
            point = obj.points(id_list == id);
            if length(point) > 1
                warning('%d points share the same id=%d', length(point), id);
            elseif isempty(point)
                warning('No points with id=%d found', id);
            end
        end
        
        function link = linkID(obj, id)
            id_list = [obj.links.id];
            link = obj.links(id_list == id);
            if length(link) > 1
                warning('%d points share the same id=%d', length(link), id);
            elseif isempty(link)
                warning('No points with id=%d found', id);
            end
        end
    end
end