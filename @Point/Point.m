classdef Point < handle
    properties
        pos = zeros(1,3); %current position (x,y,z)
        pos_r = zeros(1,3); %reference position at 0 spring force)
        
        vel = zeros(1,3);
        mass = 0;
        links = [];
        DOF = [1, 1, 1]; %free to move in all directions by default
        
        parents = [];
        
        id;
        color = [0, 0, 0]; %blue
    end
    methods
        function obj = Point(pos)
        % Constructor
            if nargin == 1
                obj.pos = pos;
                obj.pos_r = pos;
            else
                error('Either leave arguments blank or supply 1x3 position vector');
            end
        end
        function s = getState(obj)
        % Returns the state column vector of this point, in the form
        % [x; x'; y; y'; z; z']
%             if obj.parents(1).dimensions == 3
                s = [obj.pos(1); obj.vel(1); obj.pos(2); obj.vel(2); obj.pos(3); obj.vel(3)];
%             elseif obj.parents(1).dimensions == 2
%                 s = [obj.pos(1); obj.vel(1); obj.pos(2); obj.vel(2)];
%             end
        end
        function new_link = connectTo(obj, other_point)
            new_link = Link(obj, other_point);
            obj.addLink(new_link);
            other_point.addLink(new_link);
        end
        
        function addLink(obj, new_link)
            obj.links = [obj.links, new_link];
        end
        
        function reduceLinks(obj)
        % Merges parallel links attached to Point OBJ
            i = 1;
            while i < length(obj.links)
                j = 1;
                while j < i
                    linki = obj.links(i);
                    linkj = obj.links(j);
%                     linki.printLink();
%                     linkj.printLink();
                    if checkParallel(linki, linkj)
                        linkj.merge(linki); %deletes linki
                        i = i-1;
                        break;
                    end
                    j = j+1;
                end
                i = i+1;
            end
        end
        
        function link = connected(obj, target_point)
        % CONNECTED Returns empty link if OBJ isn't connected to TARGET_POINT
            num_links = length(obj.links);
            for i = 1:num_links
                link = obj.links(i);
                [other_point, ~] = link.getOther(obj);
                if other_point == target_point
                    return;
                end
            end
            link = []; %Returns empty if not connected
        end
        
        function mergeInto(obj, target_point)
            target_point.DOF = min(target_point.DOF, obj.DOF); %any degrees of freedom that are fixed remain fixed
            obj.replaceReferencesWith(target_point); % every link and voxel that referenced OBJ should now reference TARGET_POINT
            target_point.reduceLinks(); %handles redundant links
            target_point.refresh(); %refreshes mass and color
        end
        function replaceReferencesWith(obj, target_point)
        % Replace OBJ with TARGET_POINT in all of OBJ's links and parents
            for i = 1:length(obj.links)
                this_link = obj.links(i);
                if this_link.A == obj
                    this_link.A = target_point;
                    target_point.links = [target_point.links this_link];
                elseif this_link.B == obj
                    this_link.B = target_point;
                    target_point.links = [target_point.links this_link];
                end
            end
            
            % Replace obj with target_point in all of obj's parents
            for i = 1:length(obj.parents)
                this_parent = obj.parents(i);
                [~, index] = this_parent.getPoint(obj.pos_r);
                this_parent.points(index) = target_point;
                target_point.parents = [target_point.parents this_parent];
            end
        end
        
        function refresh(obj)
        % Refreshes any properties that might need to updated after altering the
        % Structure

            % Color
%             obj.color = mean(transpose(reshape([obj.parents.color], 3, [])), 1);
            if any(obj.DOF == 0)
                obj.color = [0.5, 0.5, 0.5];
            end
            
            % Calculate mass
            m = 0;
            for i = 1:length(obj.parents)
                p = obj.parents(i);
                m = m + p.density/p.volume/p.n;
            end
            obj.mass = m;
        end
            
    end
end