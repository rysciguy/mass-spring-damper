classdef Voxel < Structure
    properties
        origin = zeros(1,3);
        volume;
    end
    methods
        function obj = Voxel(varargin)
            % Defaults
            a = 1;
            obj.dimensions = 2;

            for index = 1:2:nargin-1
                switch lower(varargin{index}) %key
                    case 'dimensions'
                        obj.dimensions = varargin{index+1};
                    case 'unit'
                        a = varargin{index+1};
                    case 'origin'
                        obj.origin = varargin{index+1};
                    case 'parent'
                        obj.parent = varargin{index+1};
                    case 'stiffness'
                        obj.stiffness = varargin{index+1};
                    case 'damping'
                        obj.damping = varargin{index+1};
                    case 'density'
                        obj.density = varargin{index+1};
                    case 'color'
                        obj.color = varargin{index+1};
                end
            end
            
            if obj.dimensions == 2
                % unit a square centered on origin
                coords = obj.origin + [-a/2, a/2, 0;
                                      a/2, a/2, 0;
                                      a/2, -a/2, 0;
                                      -a/2, -a/2, 0];
                obj.volume = a^2;
            elseif obj.dimensions == 3
                coords = [0, 0, 0;
                          0, a, 0;
                          a, a, 0;
                          a, 0, 0;
                          0, 0, a;
                          0, a, a;
                          a, a, a;
                          a, 0, a] + obj.origin - [a/2, a/2, a/2];
                obj.volume = a^3;
            end
          
            n = size(coords, 1);
            for i = 1:n
               this = Point(coords(i, :));
               this.parents = [obj];
               this.mass = obj.density*obj.volume/n;
               this.id = i;
               obj.addPoint(this);
               for j = 1:i-1
                   that = obj.points(j);
                   new_link = this.connectTo(that);
                   obj.links = [obj.links new_link];
               end
            end
        end
           
    end
end