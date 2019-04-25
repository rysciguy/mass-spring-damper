classdef Gene_Node < Gene
    properties
        pos;
        id;
    end
    
    methods
        function obj = Gene_Node(i, pos, id)
            obj.innovation = i;
            obj.pos = pos;
            obj.id = id;
        end
        function express(obj, bridge)
            pt = Point(obj.pos);
            pt.id = obj.id;
            pt.parents = bridge;
            bridge.addPoint(pt);
        end
    end
end