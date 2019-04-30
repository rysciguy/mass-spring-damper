classdef Gene_Link < Gene
    properties
        A;
        A_id;
        A_pos;
        A_static = false;
        
        B;
        B_id;
        B_pos;
        B_static = false;
        
        link;
        link_id;
        stiffness;
    end
    
    methods
        function obj = Gene_Link(A_id, A_pos, B_id, B_pos, stiffness, A_static, B_static)
            if nargin>5
                if A_static
                    obj.A_static = true;
                end
                if B_static
                    obj.B_static = true;
                end
            end
            
            obj.innovation = obj.incrementInnovation();
            
            obj.A_id = A_id;
            obj.A_pos = A_pos;
            obj.B_id = B_id;
            obj.B_pos = B_pos;
            
            obj.stiffness = stiffness;
            obj.link_id = obj.incrementLinks();
        end
        
        function express(obj, bridge)
            obj.A = checkPoint(obj, bridge, obj.A_id, obj.A_pos, obj.A_static);
            obj.B = checkPoint(obj, bridge, obj.B_id, obj.B_pos, obj.B_static);
            
            obj.link = obj.A.connectTo(obj.B);
            obj.link.stiffness = obj.stiffness;
            obj.link.id = obj.link_id;
            bridge.links = [bridge.links obj.link];
            
            if ~obj.enabled
                obj.link.enabled = obj.enabled;
            end
        end
        
        function pt = checkPoint(obj, bridge, id, pos, static)
            pt = bridge.pointID(id);
            if isempty(pt)
                pt = Point(pos);
                pt.id = id;
                pt.parents = bridge;
                bridge.addPoint(pt);
                pt.static = static;
            elseif ~pt.static
                if ~isempty(pt.pos)
                    pt.pos = pos;
                end
            end
        end
    end
end