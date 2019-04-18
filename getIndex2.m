function n = getIndex2(i_node, d, dimensions)
% Give the index of the row or column corresponding to the given values
%   i_node:     index of node
%   d:  1, 2, or 3 for x, y, or z
%   dimensions: number of dimensions (2 or 3)
    if any(d > dimensions) || any(d < 1)
        error('d out of range [1:dimensions]');
    end
    
    n = 1 + dimensions*(i_node-1);
    n = n + (d-1);
end