function [coord] = getvel(i, x)
% Returns the velocity of node I from state space vector X
    row = 1 + 6*(i-1);
    
    coord(1) = x(row + 1);
    coord(2) = x(row + 3);
    coord(3) = x(row + 5);
end