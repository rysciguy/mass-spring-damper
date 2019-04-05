classdef Gene_Node < Gene
    properties
        point;
    end
    
    methods
        function obj = Gene_Node(i, pos)
            obj.innovation = i;
            obj.point = Point(pos);
        end
        function express(obj, bridge)
            bridge.addPoint(obj.point);
            obj.point.parents = bridge;
        end
    end
end