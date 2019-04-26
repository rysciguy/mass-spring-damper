classdef Gene_Node < Gene
    properties
        pos;
        pt_id;
    end
    
    methods
        function obj = Gene_Node(pos)
            obj.pos = pos;
        end
        
        function increment(obj)
             obj.pt_id = obj.genotype.incrementPoints();
        end
        
        function express(obj, bridge)
            pt = Point(obj.pos);
            pt.id = obj.pt_id;
            pt.parents = bridge;
            bridge.addPoint(pt);
        end
    end
end