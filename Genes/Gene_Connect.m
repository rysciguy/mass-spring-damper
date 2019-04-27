classdef Gene_Connect < Gene
    properties
        pt_A_id;
        pt_B_id;
        stiffness;
        
        new_id;
        
        %if flagged, that means that this gene only reenabled an existing link instead of creating a new one
        % so the link with id = new_id doesn't actually exist
        flagged = false; 
    end
    
    methods
        function obj = Gene_Connect(pt_A_id, pt_B_id, stiffness)
            obj.innovation = obj.incrementInnovation;
            
            obj.pt_A_id = pt_A_id;
            obj.pt_B_id = pt_B_id;
            obj.stiffness = stiffness;
            obj.new_id = obj.incrementLinks();
        end
        
        function express(obj, bridge)
            pt_A = bridge.pointID(obj.pt_A_id);
            pt_B = bridge.pointID(obj.pt_B_id);
            old_link = pt_A.connected(pt_B);
            if isempty(old_link)
                new_link = pt_A.connectTo(pt_B);
                new_link.stiffness = obj.stiffness;
                new_link.id = obj.new_id;
                bridge.links = [bridge.links new_link];
            else
                old_link.enabled = 1;
            end
        end
    end
end