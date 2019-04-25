classdef Gene_Nudge < Gene
    properties
        pt_id;
        dx;
    end
    
    methods
        function obj = Gene_Nudge(i, pt_id, dx)
            obj.innovation = i;
            obj.pt_id = pt_id;
            obj.dx = dx;
        end
        
        function express(obj, bridge)
            pt = bridge.pointID(obj.pt_id);
            pt.pos = pt.pos + obj.dx;
        end
    end
end