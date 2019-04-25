classdef Gene_Connect < Gene
    properties
        pt_A_id;
        pt_B_id;
        stiffness;
        link_id;
        
    end
    
    methods
        function obj = Gene_Connect(i, pt_A_id, pt_B_id, stiffness, link_id)
            obj.innovation = i;
            obj.pt_A_id = pt_A_id;
            obj.pt_B_id = pt_B_id;
            obj.stiffness = stiffness;
            obj.link_id = link_id;
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
                bridge.links = [bridge.links new_link];
            end
        end
    end
end