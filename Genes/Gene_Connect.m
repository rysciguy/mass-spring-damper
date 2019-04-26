classdef Gene_Connect < Gene
    properties
        pt_A_id;
        pt_B_id;
        stiffness;
    end
    
    methods
        function obj = Gene_Connect(pt_A_id, pt_B_id, stiffness)
            obj.pt_A_id = pt_A_id;
            obj.pt_B_id = pt_B_id;
            obj.stiffness = stiffness;
        end
        function express(obj, bridge)
            pt_A = bridge.pointID(obj.pt_A_id);
            pt_B = bridge.pointID(obj.pt_B_id);
            existing_link = pt_A.connected(pt_B);
            if ~isempty(existing_link)
                existing_link.enabled = 1;
            else
                new_link = pt_A.connectTo(pt_B);
                new_link.stiffness = obj.stiffness;
                new_link.id = obj.genotype.incrementLinks();
                bridge.links = [bridge.links new_link];
            end
        end
    end
end