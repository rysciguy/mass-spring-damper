classdef Gene_Split < Gene
    properties
        link_id;
        pt_id;
        
        first_id;
        second_id;
    end
    
    methods
        function obj = Gene_Split(link_id)
            obj.innovation = obj.incrementInnovation;
            obj.link_id = link_id;
            obj.pt_id = obj.incrementPoints();
            
            obj.first_id = obj.incrementLinks();
            obj.second_id = obj.incrementLinks();
        end

        function express(obj, bridge)
            old_link = bridge.linkID(obj.link_id);
            
%             if ~isempty(old_link)
                A = old_link.A;
                B = old_link.B;
                stiffness = old_link.stiffness;
    %             old_link.removeLink();
%                 old_link.enabled = 0;

                center_pos = A.pos + (B.pos-A.pos)/2;
                C = Point(center_pos);
                C.id = obj.pt_id;
                C.parents = bridge;
                bridge.addPoint(C);

                first = A.connectTo(C);
                first.stiffness = stiffness;
                first.id = obj.first_id;

                second = B.connectTo(C);
                second.stiffness = stiffness;
                second.id = obj.second_id;

                bridge.links = [bridge.links first second];
%             end
        end
    end
end