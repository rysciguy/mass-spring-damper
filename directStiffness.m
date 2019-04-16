function U = directStiffness(structure, links, loads, dimensions)
%% Constants
m = 1;       %mass
% k = 1;       %spring constant
% dimensions = 2;
% g = 0.01;
% c = 1;     %damping constant

%% Build matrix
% dxdt = A*x + b
% F = Ku -> u = inv(K)*F
n = structure.countPoints();
% state = structure.getState(); %state vector
    
% [links, ~] = structure.getLinkMatrix();

K = zeros(n*dimensions, n*dimensions); %global stiffness matrix
DOF = zeros(n, dimensions);
% F = zeros(n*dimensions, 1);
F = reshape(loads(:, 1:dimensions)', 1, dimensions*n)';
U = zeros(n*dimensions, 1); %displacement

%Stiffness matrix
for i = 1:n %iterate nodes
    DOF(i, :) = structure.points(i).DOF(1:dimensions);
%     if DOF(i) == 1 %node must not be fixed
    for j = 1:n %iterate target nodes
        if links(i, j) > 0 %skip nodes that aren't linked
            i_ind = getIndex2(i, 1:dimensions, dimensions);
            j_ind = getIndex2(j, 1:dimensions, dimensions);
%             i_ind = [(i-1)*dimensions + 1 : (i-1)*dimensions+(dimensions-1)];
%             j_ind = [(j-1)*dimensions + 1 : (j-1)*dimensions+(dimensions-1)];
            pos_i = structure.points(i).pos;
            pos_j = structure.points(j).pos;
%             pos_i = state(getindex(i, 1:dimensions, 0));
%             pos_j = state(getindex(j, 1:dimensions, 0));
%                 i2j = getcoord(j,x) - getcoord(i,x); %vector pointing from node i (base) to node j (target)
%                 i2jr = getcoord(j, xr) - getcoord(i, xr); %vector from base to target while at rest
            i2j = pos_j - pos_i;
            L = norm(i2j); %length of relative position vector
            theta = atan2(i2j(2), i2j(1));
            c = cos(theta);
            s = sin(theta);
            K_m = [c^2 c*s -c^2 -c*s; %member stiffness matrix converted to global coordinates
                   c*s s^2 -c*s -s^2;
                   -c^2 -c*s c^2 c*s;
                   -c*s -s^2 c*s s^2]*links(i, j);

%             for ii = 1:dimensions
%                 for jj = 1:dimensions
%                     K_xy = K_m( (ii-1)+1 : (ii-1)*dimensions, K_m( (jj-1)+1:(jj-1)+1) );
%                     K(

            indices = [i_ind j_ind];
                    
            K(indices, indices) = K(indices, indices) + K_m;
        end % if links()
%         end % if DOF(i)==1
    end % for j = 1:N 
end % for i = 1:N

% Boundary conditions
% removed = [];
free = [];
for i = 1:n
    for d = 1:dimensions
%         if DOF(i, d) == 0
%             ind = (i-1)*3 + 1 + (d-1);
% %             K(ind, :) = [];
% %             K(:, ind) = [];
%             removed = [removed ind];
%         end
        if DOF(i, d) == 1
            ind = (i-1)*dimensions + 1 + (d-1);
            free = [free ind];
        end
    end
end

% K(removed, :) = [];
% K(:, removed) = [];

% Gravity
% F( getIndex2(1:n, 2, dimensions) ) = -g;
% F(removed) = [];

% Solve
U(free) = K(free, free)\F(free);
   
% dxdt = A*(x) + b;

% Debugging
% posx = x( getindex(1:N, 1, 0) ) - xr( getindex(1:N, 1, 0));
% posy = x (getindex(1:N, 2, 0) ) - xr( getindex(1:N, 2, 0));
% vel = dxdt( getindex(1:N, 1, 0) );
% Fx = dxdt( getindex(1:N, 1, 1) );
% Fy = dxdt (getindex(1:N, 2, 1) );
% x_y_Fx_Fy = [posx posy Fx Fy]

% column = [posx; posy]
% A_2 = A( getindex(2, 1:2, 1), [getindex( 1, 1:2, 0 ), getindex( 2, 1:2, 0)] )

end