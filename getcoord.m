function [coord] = getcoord(i, x)
% Gets the (x,y,z) coordinates of point i within the state vector x
    row = 1 + 6*(i-1);
    
    coord(1) = x(row);
    coord(2) = x(row + 2);
    coord(3) = x(row + 4);
end