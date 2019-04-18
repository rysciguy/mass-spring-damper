function U = directStiffness(structure, links, loads, dimensions)

%Parameters
% conditioning_threshold = 1e-20;

% Set up
% F = Ku -> u = inv(K)*F
n = structure.countPoints();

K = zeros(n*dimensions, n*dimensions); %global stiffness matrix
DOF = zeros(n, dimensions); %degrees of freedom
% F = zeros(n*dimensions, 1);
F = reshape(loads(:, 1:dimensions)', 1, dimensions*n)'; %force column vector
U = zeros(n*dimensions, 1); %displacement column vector

% Build stiffness matrix
for i = 1:n %iterate nodes
    DOF(i, :) = structure.points(i).DOF(1:dimensions);
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

            i2j = pos_j - pos_i;
            theta = atan2(i2j(2), i2j(1));
            c = cos(theta);
            s = sin(theta);
            K_m = [c^2 c*s -c^2 -c*s; %member stiffness matrix converted to global coordinates
                   c*s s^2 -c*s -s^2;
                   -c^2 -c*s c^2 c*s;
                   -c*s -s^2 c*s s^2]*links(i, j);

            indices = [i_ind j_ind];
                    
            K(indices, indices) = K(indices, indices) + K_m;
        end % if links()
%         end % if DOF(i)==1
    end % for j = 1:N 
end % for i = 1:N

% Boundary conditions
% Rows and columns corresponding to fixed degrees of freedom are not
% considered
free = [];
for i = 1:n
    for d = 1:dimensions
        if DOF(i, d) == 1
            ind = (i-1)*dimensions + 1 + (d-1);
            free = [free ind];
        end
    end
end

% Solve
% c = rcond(K);
% if c < conditioning_threshold %stiffness matrix is ill-conditioned
%     U(1) = inf;
% else
%     U(free) = K(free, free)\F(free);
% end
U(free) = K(free, free)\F(free);

end