classdef Gene_Node < Gene
    properties
        pos;
        pt_id;
        static = false;
    end
    
    methods
        function obj = Gene_Node(pos, varargin)
            for index = 1:2:nargin-1
                if nargin-1==index, break, end
                switch lower(varargin{index}) %key
                    case 'static'
                        obj.static = true;
                end
            end
            
            obj.innovation = obj.incrementInnovation;
            
            obj.pos = pos;
            obj.pt_id = obj.incrementPoints();
        end

        function express(obj, bridge)
            pt = Point(obj.pos);
            pt.id = obj.pt_id;
            pt.parents = bridge;
            bridge.addPoint(pt);
        end
    end
end