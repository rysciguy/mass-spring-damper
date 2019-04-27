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
            obj.pt_A_id = pt_A_id;
            obj.pt_B_id = pt_B_id;
            obj.stiffness = stiffness;
        end
        
        function increment(obj)
             obj.new_id = obj.genotype.incrementLinks();
        end
        
        function express(obj, bridge)
            pt_A = bridge.pointID(obj.pt_A_id);
            pt_B = bridge.pointID(obj.pt_B_id);
            if ~isempty(pt_A) && ~isempty(pt_B)
                existing_link = pt_A.connected(pt_B);
                if ~isempty(existing_link)
                    existing_link.enabled = 1;
                else
                    obj.flagged = true;

                    new_link = pt_A.connectTo(pt_B);
                    new_link.stiffness = obj.stiffness;
                    new_link.id = obj.new_id;
                    bridge.links = [bridge.links new_link];
                end
            end
        end
    end
end