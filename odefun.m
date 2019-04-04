function dxdt = odefun(t, x, x_r, structure, K, B, gravity)

N = structure.countPoints();

%% Build matrix
% dxdt = A*x + b

A = zeros(N*6, N*6);

for i = 1:N %iterate nodes
    node_i = structure.points(i);
    m = node_i.mass;
    % Velocity rows
    for d = 1:3 %iterate dimensions
        if node_i.DOF(d) == 1 %node must not be fixed
            row = getindex(i, d, 0); %velocity row
            col = getindex(i, d, 1); %velocity column
            A(row, col) = 1; %velocity_i = velocity_i
        end
    end

    % Acceleration rows
    for j = 1:N %iterate target nodes
        node_j = structure.points(j);
%         link = node_i.connected(node_j);
        if K(i, j) > 0 %skip nodes that aren't linked
            i2j = getcoord(j,x) - getcoord(i,x); %vector pointing from node i (base) to node j (target)
            i2j_r = getcoord(j, x_r) - getcoord(i, x_r); %vector from base to target while at rest
            L = norm(i2j); %length of relative position vector
            L_r = norm(i2j_r);

            % Forces
            % m*x''_i = F*(x_j - x_i)/L
            F_spring = K(i,j)*( L - L_r ); %magnitude of spring force

            vel = getvel(j, x) - getvel(i, x); %magnitude of damping force
            F_damp = B(i,j)*dot(vel, i2j/L);

            accel = (F_spring+F_damp) / (L*m); 

            for d = 1:3 %iterate dimensions
                if node_i.DOF(d)
                    % Spring
                    row = getindex(i, d, 1); %acceleration_i row

                    col = getindex(j, d, 0); %position_j col
                    A(row, col) = accel;

                    col = getindex(i, d, 0); %position_i col
                    A(row, col) = A(row, col) - accel;
                end
            end % for d = 1:3
        end % if ~empty(links)
    end % for j = 1:N 
end % for i = 1:N

b = zeros(N*6, 1);
for i = 1:N
    node_i = structure.points(i);
    m = node_i.mass;

    for d = 1:3
        if node_i.DOF(d) == 1
            b( getindex(i, d, 1) ) = gravity(d)/m;
        end
    end
end
   
dxdt = A*(x) + b;

% Debugging
% posx = x( getindex(1:N, 1, 0) ) - x_r( getindex(1:N, 1, 0));
% posy = x (getindex(1:N, 2, 0) ) - x_r( getindex(1:N, 2, 0));
% vel = dxdt( getindex(1:N, 1, 0) );
% Fx = dxdt( getindex(1:N, 1, 1) );
% Fy = dxdt (getindex(1:N, 2, 1) );
% x_y_Fx_Fy = [posx posy Fx Fy]

% column = [posx; posy]
% A_2 = A( getindex(2, 1:2, 1), [getindex( 1, 1:2, 0 ), getindex( 2, 1:2, 0)] )
end