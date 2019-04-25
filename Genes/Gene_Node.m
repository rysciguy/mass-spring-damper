classdef Gene_Node < Gene
    properties
        pos;
        pt_id;
    end
    
    methods
        function obj = Gene_Node(i, pos)
            obj.innovation = i;
            obj.pos = pos;
        end
        function express(obj, bridge)
            pt = Point(obj.pos);
            pt.pt_id = obj.genotype.incrementPoints();
            pt.parents = bridge;
            bridge.addPoint(pt);
        end
    end
end