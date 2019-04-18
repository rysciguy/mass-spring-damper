classdef Gene_Nudge < Gene
    properties
        point_index;
        dx;
    end
    
    methods
        function obj = Gene_Nudge(i, point_index, dx)
            obj.innovation = i;
            obj.point_index = point_index;
            obj.dx = dx;
        end
        
        function express(obj, bridge)
            bridge.points(obj.point_index).pos = bridge.points(obj.point_index).pos + obj.dx;
        end
    end
end