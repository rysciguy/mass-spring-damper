classdef Structure < handle
% STRUCTURE objects hold Points and Links

    properties
        points = Point.empty();
        links = []
        children = []
        parents = [];
        n = 0;
        
        stiffness = 1;
        damping = 1;
        density = 1;
        
        dimensions; % 2 or 3
        
        color = [0, 0.4470, 0.7410]; %blue
    end
    methods
        function n = countPoints(obj)
            n = length(obj.points);
            obj.n = n;
        end
        
        function addPoint(obj, source_point)
        % Adds an existing Point object to the Structure, and merges it into an
        % existing point if they overlap
            existing_coords = obj.getCoords();
            
            if class(source_point) ~= 'Point'
                error('Arguments must be Point objects')
            elseif ismember(source_point, obj.points)
                sprintf('Point is already in structure')
                return;
            end

            new_coords = source_point.pos_r;
            [Lia, Locb] = ismember(new_coords, existing_coords, 'rows');
            if Lia % this member of new_coords is found in old_coords
                target_point = obj.points(Locb);
                source_point.mergeInto(target_point);
            else % this is a new point
                obj.points = [obj.points, source_point];
                obj.n = obj.n + 1;
            end
        end %addPoints()
               
        function links = getLinks(obj)
        % Returns a vector of links belonging to the Structure
            links = [];
            for i = 1:countPoints(obj)
                links = union(links, obj.points(i).links);
            end
        end %getLinks()
        
        function coords = getCoords(obj)
        % Returns an nx3 array of coordinates in the Structure
            coords = transpose(reshape([obj.points.pos], 3, []));
%             coords = zeros(obj.n, 3);
%             for i = 1:obj.n
%                 coords(i, :) = obj.points(i).pos_r;
%             end
        end %getCoords()
        
        function coords = getRefCoords(obj)
        % Returns an nx3 array of reference coordinates in the Structure
            coords = transpose(reshape([obj.points.pos_r], 3, []));
        end %getRefCoords()
        
        function [point, Locb] = getPoint(obj, target_coords)
        % Returns the Point and its index within obj.points specified by its
        % [x,y,z] coordinates
            old_coords = obj.getCoords();
            [Lia, Locb] = ismember(target_coords, old_coords, 'rows');
            if Lia % this member of new_coords is found in old_coords
                point = obj.points(Locb);
            else
                error('Point not found');
            end
        end %getPoint()
        
        function [voxel, Locb] = getVoxel(obj, target_coords)
        % Returns the voxel and its index within obj.children whose origin is at
        % TARGET_COORDS
            origins = transpose(reshape([obj.children.origin], 3, []));
            [Lia, Locb] = ismember(target_coords, origins, 'rows');
            if Lia % this member of new_coords is found in old_coords
                voxel = obj.children(Locb);
            else
                error('Point not found');
            end
        end
        
        function incorporate(obj, source_structure)
        % Incorporates SOURCE_STRUCTURE into OBJ
            source_structure.parents = [source_structure.parents obj];
            obj.dimensions = source_structure.dimensions;
            for i = 1:source_structure.countPoints()
                source_point = source_structure.points(i);
                obj.addPoint(source_point);
            end
            obj.links = union(obj.links, source_structure.links);
            obj.children = [obj.children source_structure];
        end
        
        function s = getState(obj)
        % Concatenates the state vectors of each Point of the Structure
            per = 6; %obj.dimensions * 2;
            s = zeros(obj.n*per, 1);
            for i = 1:obj.n
                start = per*(i-1)+1;
                s([start:(start+per-1)]) = obj.points(i).getState();
            end
        end
        
        function refresh(obj)
        % Refreshes the mass of the Points and the stiffness/damping/color of the Links within the Structure
            obj.n = obj.countPoints();
            for i = 1:obj.n
                obj.points(i).refresh();
            end
        
            obj.links = obj.getLinks();
            for i = 1:length(obj.links)
                obj.links(i).refresh(); 
            end
        end
        
        function points = findPoints(obj, varargin)
            all_coords = obj.getCoords();
            target_coords = all_coords;
            for i = 1:size(varargin, 2)
                switch varargin{i}
                    case 'left'
                        boundary = min(all_coords(:,1));
                        indices = find(all_coords(:,1)==boundary);
                    case 'right'
                        boundary = max(all_coords(:,1));
                        indices = find(all_coords(:,1)==boundary);
                    case 'front'
                        boundary = min(all_coords(:,2));
                        indices = find(all_coords(:,2)==boundary);
                    case 'back'
                        boundary = max(all_coords(:,2));
                        indices = find(all_coords(:,2)==boundary);
                    case 'top'
                        boundary = max(all_coords(:,obj.dimensions));
                        indices = find(all_coords(:,obj.dimensions)==boundary);
                    case 'bottom'
                        boundary = min(all_coords(:,obj.dimensions));
                        indices = find(all_coords(:,obj.dimensions)==boundary);
                    otherwise
                        error('Side "%s" not recognized', varargin{i});
                end
                
                target_coords = intersect(target_coords, all_coords(indices,:), 'rows');
            end
            
            points = obj.getPoint(target_coords);
        end %findPoints()
        
        function [K, B] = getLinkMatrix(obj)
%             links = obj.getLinks();
%             A = [links.A];
%             B = [links.B];
%             C = [A.pos; B.pos];
%             D = reshape(C, 
            K = zeros(obj.n, obj.n);
            B = K;
            for i = 1:obj.n
                for j = i:obj.n
                    link = obj.points(i).connected(obj.points(j));
                    if ~isempty(link)
                        K(i, j) = link.stiffness;
                        B(i, j) = link.damping;
                    end
                end
            end
            
            % Flip half of matrix over the diagonal to make a symmetric matrix
            % https://www.mathworks.com/matlabcentral/answers/282528-flip-half-of-matrix-over-the-diagonal-to-make-a-symmetric-matrix
            K = (K+K') - eye(size(K,1)).*diag(K);
            B = (B+B') - eye(size(B,1)).*diag(B);
        end
        
        function [link_coords, link_colors] = getLinkData(obj)          
%             num_links = length(obj.links);
%             
%             link_coords = zeros(2,3,num_links);
%             link_colors = zeros(num_links, 3);
%             
%             for i = 1:num_links
%                 link_coords(:,:,i) = [obj.links(i).A.pos; obj.links(i).B.pos];
%                 link_colors(i, :) = obj.links(i).color;
%             end
            
         % Getting link_coords is more efficient, but getting link_colors is
         % inefficient
            K = obj.getLinkMatrix();
            tic
            [As, Bs, ks] = find(triu(K));
            num_links = length(ks);
            link_coords = zeros(2, 3, num_links);
            link_colors = zeros(num_links, 3);
            
            all_coords = obj.getCoords();
            for i = 1:num_links
                link_coords(1,:,i) = all_coords(As(i),:);
                link_coords(2,:,i) = all_coords(Bs(i),:);
                
                link = connected(obj.getPoint(link_coords(1,:,i)), obj.getPoint(link_coords(2,:,i)));
                link_colors(i,:) = link.color;
            end
        end
    end
end