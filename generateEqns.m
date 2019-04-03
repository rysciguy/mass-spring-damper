function generateEqns(structure, gravity)

fileID = fopen('autoODE.m', 'wt');
fprintf(fileID, 'function Sd = myODEfunc(t,S)\n');

n = structure.n;
dimensions = 3; %structure.dimensions;
fprintf(fileID, 'Sd = zeros(%d, 1);\n', n*dimensions*2);
for i=1:n
    point_i = structure.points(i);
    num_links = length(point_i.links);
    
    for d = 1:dimensions
        if point_i.DOF(d) == 1
            % Velocity
            formatSpec = 'Sd(%d) = S(%d);\n';
            fprintf(fileID, formatSpec, getindex(i, d, 0), getindex(i, d, 1));

            % Start line for acceleration
            fprintf(fileID, 'Sd(%d) = (', getindex(i, d, 1));

            % Link forces
            for l = 1:num_links
                link = point_i.links(l);
                point_j = link.getOther(point_i);
                [~, j] = structure.getPoint( point_j.pos );
                % Spring force
                if link.stiffness > 0
%                     if dimensions == 3
                        formatSpec = '+ %f *((S(%d)-S(%d))- %f *((S(%d)-S(%d))/sqrt((S(%d)-S(%d))^2+(S(%d)-S(%d))^2+(S(%d)-S(%d))^2)))';
                        fprintf(fileID, formatSpec,...
                            link.stiffness,...
                            getindex(j,d,0), getindex(i,d,0),...
                            link.L0,...
                            getindex(j,d,0), getindex(i,d,0),...
                            getindex(j,1,0), getindex(i,1,0),...
                            getindex(j,2,0), getindex(i,2,0),...
                            getindex(j,3,0), getindex(i,3,0));
%                     elseif dimensions == 2
%                         formatSpec = '+ %f *((S(%d)-S(%d))- %f *((S(%d)-S(%d))/sqrt((S(%d)-S(%d))^2+(S(%d)-S(%d))^2)))';
%                         fprintf(fileID, formatSpec,...
%                             link.stiffness,...
%                             getindex(j,d,0), getindex(i,d,0),...
%                             link.L0,...
%                             getindex(j,d,0), getindex(i,d,0),...
%                             getindex(j,1,0), getindex(i,1,0),...
%                             getindex(j,2,0), getindex(i,2,0));
%                     end
                end
                
                if link.damping > 0
%                     if dimensions == 3
                        % F_damp = b*[vel.unit]unit = b*[vel.pos]*(x2-x1)/L^2
                        formatSpec = '+ %f*((S(%d)-S(%d))*(S(%d)-S(%d))+(S(%d)-S(%d))*(S(%d)-S(%d))+(S(%d)-S(%d))*(S(%d)-S(%d)))*(S(%d)-S(%d))/((S(%d)-S(%d))^2+(S(%d)-S(%d))^2+(S(%d)-S(%d))^2)';
                        fprintf(fileID, formatSpec,...
                            link.damping,...
                            getindex(j,1,1),getindex(i,1,1),... %x velocity
                            getindex(j,1,0),getindex(i,1,0),... %x position
                            getindex(j,2,1),getindex(i,2,1),... %y velocity
                            getindex(j,2,0),getindex(i,2,0),... %y position
                            getindex(j,3,1),getindex(i,3,1),... %z velocity
                            getindex(j,3,0),getindex(i,3,0),... %z position
                            getindex(j,d,0),getindex(i,d,0),... %component of unit vector
                            getindex(j,1,0),getindex(i,1,0),... %length x
                            getindex(j,2,0),getindex(i,2,0),... %length y
                            getindex(j,3,0),getindex(i,3,0));   %length z
%                     elseif dimensions == 2
%                         formatSpec = '+ %f*((S(%d)-S(%d))*(S(%d)-S(%d))+(S(%d)-S(%d))*(S(%d)-S(%d)))*(S(%d)-S(%d))/((S(%d)-S(%d))^2+(S(%d)-S(%d))^2)';
%                         fprintf(fileID, formatSpec,...
%                             link.damping,...
%                             getindex(j,1,1),getindex(i,1,1),... %x velocity
%                             getindex(j,1,0),getindex(i,1,0),... %x position
%                             getindex(j,2,1),getindex(i,2,1),... %y velocity
%                             getindex(j,2,0),getindex(i,2,0),... %y position
%                             getindex(j,d,0),getindex(i,d,0),... %component of unit vector
%                             getindex(j,1,0),getindex(i,1,0),... %length x
%                             getindex(j,2,0),getindex(i,2,0)); %length y
%                     end
                end
                            
            end
            
            % Gravity
            formatSpec = ' + %f';
            fprintf(fileID, formatSpec, gravity(d)/point_i.mass);
            
            % End acceleration line (divide by mass)
            fprintf(fileID, ')/%f;\n', point_i.mass); 
        end
    end
end

fprintf(fileID, 'end\n');
fclose(fileID);

end
    