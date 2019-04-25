classdef Gene_Split < Gene
    properties
        link_id;
        pt_id;
    end
    
    methods
        function obj = Gene_Split(i, link_id)
            obj.innovation = i;
            obj.link_id = link_id;
%             obj.pt_id = pt_id;
        end
        
        function express(obj, bridge)
            old_link = bridge.linkID(obj.link_id);
            A = old_link.A;
            B = old_link.B;
            stiffness = old_link.stiffness;
%             old_link.removeLink();
            old_link.enabled = 0;
            
            center_pos = A.pos + (B.pos-A.pos)/2;
            C = Point(center_pos);
            C.id = obj.genotype.incrementPoints;
            C.parents = bridge;
            bridge.addPoint(C);
            
            first = A.connectTo(C);
            first.stiffness = stiffness;
            
            second = B.connectTo(C);
            second.stiffness = stiffness;
            
            bridge.links = [bridge.links first second];
        end
    end
end