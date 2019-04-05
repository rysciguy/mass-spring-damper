classdef Gene_Node < Gene
    properties
        pos;
    end
    
    methods
        function obj = Gene_Node(i, pos)
            obj.innovation = i;
            obj.pos = pos;
        end
        function express(obj, bridge)
            pt = Point(obj.pos);
            pt.parents = bridge;
            bridge.addPoint(pt);
            
        end
    end
end