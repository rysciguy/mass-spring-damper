classdef Gene_Connect < Gene
    properties
        A;
        B;
        stiffness;
    end
    
    methods
        function obj = Gene_Connect(i, A, B, stiffness)
            obj.innovation = i;
            obj.A = A;
            obj.B = B;
            obj.stiffness = stiffness;
        end
        function express(obj, bridge)
            this = bridge.points(obj.A);
            that = bridge.points(obj.B);
            new_link = this.connectTo(that);
            new_link.stiffness = obj.stiffness;
            bridge.links = [bridge.links new_link];
        end
    end
end