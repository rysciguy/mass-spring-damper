function generateEqns(myObjectClassInstance)

%the assumption here is that there is an instance of a super-class that
%holds all instances of voxels, connections, point masses, etc. This
%"collector" makes it easy to pass in a reference to all the other
%sub-classes, and easily access them.

fileID = fopen('myODFfunc.m','wt');
fprintf(fileID,'function Sd =  myODFfunc(t,S)\n');

%I'm assuming you've kept a list of the point mass objects you
%created and that you can access it here by passing in the
%overall object
numPtMasses = myObjectClassInstance.numberOfPtMasses;

%similarly, I'm assuming you've defined the number of
%dimensions that you're interested in tracking (1,2,or 3)
numDim = myObjectClassInstance.numberDims;

%now, loop through all the point masses in the entire system and
%length constraints
for ptmass=1:numPtMasses
    %use an accessor function to return a reference to a specific point
    %mass object, in order to access all that point mass's data
    currPtMass = myObjectClassInstance.getCurrPtmass(ptmass);
    numLinks = currPtMass.NumLinks;  %get the number of links
    %involving this point mass
    
    for dim=1:numDim %loop over the x, y, z dimensions, if all are called
        %for. dim is the number of the current dimension we're
        %considering. The assumption is that the state var is ordered as
        %[x,vx] for 1D, [x,y,vx,vy] for 2D and [x,y,z,vx,vy,vz] for 3D
        
        %first, write out the trivial state-space mapping from velocity to
        %velocity
        formatSpec = 'Sd(%d) = S(%d);\n';
        PtMassAidx = (currPtMass.OrderInStateVar-1)*(2*numDim);    %compute the locations in the
        %state vector and S_dot where we should write. Note that each point
        %mass object has its order within the state vector conveniently
        %pre-assigned (by you) so it can be looked up. Note that order
        %isn't the same thing as array index. For example, if an object
        %only has 2 point masses, the first "OrderInStateVar" would say 1
        %and the second would say 2.
        fprintf(fileID,formatSpec, PtMassAidx+dim, PtMassAidx+dim+numDim);
        
        %next, start the line for the acceleration entry in S_dot
        fprintf(fileID,'Sd(%d) = ', PtMassAidx+dim+numDim);
        for link=1:numLinks %numLinks is the number of connections (which might
            %include both springs and dampers, or might just be one or the
            %other, depending on the type of connection
            curLink = currPtMass.GetLink(link); %use the (assumed) accessor
            %function to get the current connection
            
            otherPtMass = curLink.GetOtherPtMass(currPtMass); %get the other point mass involved in the link
            
            PtMassBidx = (otherPtMass.OrderInStateVar-1)*(2*numDim); %and get its offset into the state vector
            
            %now test if the current connection includes a spring, and if
            %so, include the equations for that particular spring
            if curLink.IncludesSpring()
                
                if numDim==3 %since the format and equation change depending on the number of dimensions, account for that
                    %we're emulating this format (assuming we're talking about
                    %forces in the x direction, which comes from the HW2 hint:
                    %k*((xb-xa)- Lrest*((xb-xa)/sqrt((xb-xa)^2+(yb-ya)^2+(zb-za)^2)))
                    %notice the use of %d when we want an integer and %f for
                    %floating point
                    formatSpec = '+ %f *((S(%d)-S(%d))- %f *((S(%d)-S(%d))/sqrt((S(%d)-S(%d))^2+(S(%d)-S(%d))^2+(S(%d)-S(%d))^2)))';
                    fprintf(fileID,formatSpec,...
                        curLink.Kvalue,...
                        PtMassBidx+dim,PtMassAidx+dim,...
                        curLink.RestLength,...
                        PtMassBidx+dim,PtMassAidx+dim,...
                        PtMassBidx+1,PtMassAidx+1,...
                        PtMassBidx+2,PtMassAidx+2,...
                        PtMassBidx+3,PtMassAidx+3);
                elseif numDim==2
                    formatSpec = '+ %f *((S(%d)-S(%d))- %f *((S(%d)-S(%d))/sqrt((S(%d)-S(%d))^2+(S(%d)-S(%d))^2)))';
                    fprintf(fileID,formatSpec,...
                        curLink.Kvalue,...
                        PtMassBidx+dim,PtMassAidx+dim,...
                        curLink.RestLength,...
                        PtMassBidx+dim,PtMassAidx+dim,...
                        PtMassBidx+1,PtMassAidx+1,...
                        PtMassBidx+2,PtMassAidx+2);
                elseif numDim==1
                    formatSpec = '+ %f *((S(%d)-S(%d))- %f)';
                    fprintf(fileID,formatSpec,...
                        curLink.Kvalue,...
                        PtMassBidx+dim,PtMassAidx+dim,...
                        curLink.RestLength);
                end
            end
            
            if curLink.IncludesDamper()
                %YOU FILL IN THIS BIT
            end    
            
        end
        
        %finally, after summing all accelerations due to connections, include
        %accel due to external forces (like gravity)
        %YOU FILL IN THIS BIT. THINK ABOUT WHICH DIMENSIONS THESE FORCES
        %ACT IN. YOU MIGHT WANT THESE FORCES TO BE STORED INDIVIDUALLY
        %PER-POINT MASS. YOU COULD ALSO INCLUDE TIME-VARYING EXTERNAL
        %FORCES HERE.
        
        %and end the accel line
        fprintf(fileID,';\n');
    end
    
end

%final cleanup/closing details for the function file
fprintf(fileID,'end\n');    %end the outer function
fclose(fileID);
%fclose('all');
end
