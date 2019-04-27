classdef Gene_Nudge < Gene
    properties
        pt_id;
        dx;
    end
    
    methods
        function obj = Gene_Nudge(pt_id, dx)
            obj.pt_id = pt_id;
            obj.dx = dx;
        end
        
        function increment(obj)
        end
        
        function express(obj, bridge)
            pt = bridge.pointID(obj.pt_id);
            
            if ~isempty(pt)
                pt.pos = pt.pos + obj.dx;
            end
        end
    end
end