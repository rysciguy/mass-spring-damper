classdef Gene_Split < Gene
    properties
        link_index;
    end
    
    methods
        function obj = Gene_Split(i, link_index)
            obj.innovation = i;
            obj.link_index = link_index;
        end
        
        function express(obj, bridge)
            old_link = bridge.links(obj.link_index);
            A = old_link.A;
            B = old_link.B;
            stiffness = old_link.stiffness;
%             old_link.removeLink();
            old_link.enabled = 0;
            
            center_pos = A.pos + (B.pos-A.pos)/2;
            C = Point(center_pos);
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