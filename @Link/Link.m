classdef Link < handle
    properties
        stiffness = 1;
        damping = 1;
        A
        B
        L0 = 0;
        
        color;
        enabled = 1;
    end
    methods
        function obj = Link(A, B, varargin)
        % Constructor
            obj.A = A;
            obj.B = B;
            obj.L0 = getLength(obj);
            
            for index = 1:2:size(varargin,2)
                switch lower(varargin{index})
                    case 'stiffness'
                        obj.stiffness = varargin{index+1};
                    case 'damping'
                        obj.damping = varargin{index+1};
                end
            end            
            obj.refresh();
        end
        
        function L = getLength(obj)
        % Returns length of link
            L = norm( obj.A.pos - obj.B.pos );
        end
        
        function V = getVel(obj)
            V = obj.B.vel - obj.A.vel;
        end
        
        function [other_point, A_or_B] = getOther(obj, first_point)
        % Gets the other point that is connected to this link besides
        % FIRST_POINT
            if first_point == obj.A
                A_or_B = 'B';
                other_point = obj.B;
            elseif first_point == obj.B
                A_or_B = 'A';
                other_point = obj.A;
            else
                A_or_B = '';
                other_point = [];
            end
        end
        
        function bool = checkParallel(obj, source_link)
        % Returns 1 if SOURCE_LINK is parallel to OBJ
            bool = 1;
            if isequal(obj.A, source_link.A)
                if isequal(obj.B, source_link.B)
                    return;
                end
            elseif isequal(obj.A, source_link.B)
                if isequal(obj.B, source_link.A)
                    return;
                end
            end
            bool = 0;
        end
                
        
        function merge(obj, source_link)
        % Merges SOURCE_LINK into OBJ
            source_link.removeLink();
            obj.refresh(); %averages stiffness, damping, color, etc.
        end
        
        function printLink(obj)
        % Prints the coordinates of both points in the link
            first = obj.A.pos_r;
            second = obj.B.pos_r;
            sprintf('(%4.2f, %4.2f, %4.2f) <--> (%4.2f, %4.2f, %4.2f)', ...
                first(1), first(2), first(3), second(1), second(2), second(3))
        end
        
        function removeLink(obj)
        % Removes references to the link in both of the link's points and in its
        % parents, then deletes the link
            obj.A.links( obj.A.links == obj ) = [];
            obj.B.links( obj.B.links == obj ) = [];
            parents = union(obj.A.parents, obj.B.parents);
            for i = 1:length(parents)
                parents(i).links( parents(i).links == obj ) = [];
            end
            delete(obj);
        end
        
        function refresh(obj)
        % Averages stiffness, damping, and color
            % Find common parents shared by both points
            parents = [obj.A.parents, obj.B.parents];
            [~, ia, ~] = unique(parents);
            dupe_indices = setdiff(1:length(parents), ia);
            common_parents = parents(dupe_indices);
    
            % Average the stiffness and damping 
            new_stiffness = max(0, mean(nonzeros([common_parents.stiffness]))); %use max() to avoid NaNs
            new_damping = max(0, mean(nonzeros([common_parents.damping])));
            obj.stiffness = new_stiffness;
            obj.damping = new_damping;

            % Combine colors from parents
            if any(obj.A.DOF==0) && any(obj.B.DOF==0)
                obj.color = [0.5, 0.5, 0.5];
            else
                obj.color = mean(transpose(reshape([common_parents.color], 3, [])), 1); 
            end
        end
            
    end
    
end