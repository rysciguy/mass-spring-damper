classdef Gene_Link < Gene
    properties
        A;
        A_id;
        A_pos;
        
        B;
        B_id;
        B_pos;
        
        link;
        link_id;
        stiffness;
        
        static = false;
    end
    
    methods
        function obj = Gene_Link(A_id, A_pos, B_id, B_pos, stiffness, static)
            if nargin==6
                if static
                    obj.static = true;
                    sprintf('static');
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
            obj.A = checkPoint(obj, bridge, obj.A_id, obj.A_pos);
            obj.B = checkPoint(obj, bridge, obj.B_id, obj.B_pos);
            
            obj.link = obj.A.connectTo(obj.B);
            obj.link.stiffness = obj.stiffness;
            obj.link.id = obj.link_id;
            bridge.links = [bridge.links obj.link];
        end
        
        function pt = checkPoint(obj, bridge, id, pos)
            pt = bridge.pointID(id);
            if isempty(pt)
                pt = Point(pos);
                pt.id = id;
                pt.parents = bridge;
                bridge.addPoint(pt);
            else
                pt.pos = pos;
            end
        end
    end
end