classdef Gene_Connect < Gene
    properties
        id_A;
        id_B;
        stiffness;
    end
    
    methods
        function obj = Gene_Connect(i, id_A, id_B, stiffness)
            obj.innovation = i;
            obj.id_A = id_A;
            obj.id_B = id_B;
            obj.stiffness = stiffness;
        end
        function express(obj, bridge)
            pt_A = bridge.pointID(obj.id_A);
            pt_B = bridge.pointID(obj.id_B);
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