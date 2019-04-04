function n = getindex(i_node, dimension, prime)
% Give the index of the row or column corresponding to the given values
%   i_node:     index of node
%   dimension:  1, 2, or 3 for x, y, or z
%   prime:      if index is for a column, prime = 1 means velocity. If index is
%               for row, prime = 1 means acceleration.

    per = 6;
    n = 1 + per*(i_node-1);
    n = n + 2*(dimension-1);
    if prime
       n = n+1;
    end
end