classdef Structure < handle
    properties
        points = []
        links = []
        children = []
        parents = [];
        
        stiffness = 1;
        damping = 1;
        density = 1;
        
        dimensions;
        mass_total = 0;
    end
    methods
        function n = countPoints(obj)
            n = length(obj.points);
        end
        
        function addPoint(obj, source_point)
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
                target_point.links = [target_point.links source_point.links];
                target_point.parents = [target_point.parents source_point.parents];
                source_point.replaceWith(target_point);
                merge(target_point);
%                 assert(target_point == new_point);
            else
                if isa(obj, 'Pixel') || isa(obj, 'Voxel')
                    source_point.parents = [source_point.parents obj];
                end
                obj.points = [obj.points, source_point];
%                 obj.mass_total = obj.mass_total + source_point.mass;
            end
        end %addPoints()
               
        function links = getLinks(obj)
            links = [];
            for i = 1:countPoints(obj)
                links = union(links, obj.points(i).links);
            end
        end %getLinks()
        
        function coords = getCoords(obj)
            % Returns an nx3 array of reference coordinates in the Structure
            n = countPoints(obj);
            coords = zeros(n, 3);
            for i = 1:n
                coords(i, :) = obj.points(i).pos_r;
            end
        end %getCoords()
        
        function [point, Locb] = getPoint(obj, target_coords)
            old_coords = obj.getCoords();
            [Lia, Locb] = ismember(target_coords, old_coords, 'rows');
            if Lia % this member of new_coords is found in old_coords
                point = obj.points(Locb);
            else
                error('Point not found');
            end
        end %getPoint()
        
        function incorporate(obj, source_structure)
%             source_structure.parents = [source_structure.parents obj];
            obj.dimensions = source_structure.dimensions;
            for i = 1:source_structure.countPoints()
                source_point = source_structure.points(i);
                obj.addPoint(source_point);
            end
            obj.children = [obj.children source_structure];
        end
        
        function s = getState(obj)
            n = length(obj.points);
            s = zeros(n*6, 1);
            for i = 1:n
                start = 6*(i-1)+1;
                s([start:start+5]) = obj.points(i).getState();
            end
        end
        
        function refresh(obj)
%             for i = 1:length(obj.points)
%                 point = obj.points(i);
%                 for j = 1:length(point.links)
%                     point.links(j).refresh();
%                 end
%             end
            obj.links = obj.getLinks();
            for i = 1:length(obj.links)
                obj.links(i).refresh(); 
            end
        end
    end
end