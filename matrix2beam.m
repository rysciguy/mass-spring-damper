function structure = matrix2beam(A)
    structure = Structure();
    structure.dimensions = 2;
    
    a = 1; %unit length
    [height, length] = size(A);
    
    getCoords = @(row, col, a, height) [a*col, a*(height-row+1), 0];
    n = length*height;
    
    % Create points
    for row = 1:height %top to bottom
        for col = 1:length %left to right
            if A(row, col) > 0
                these_coords = getCoords(row, col, a, height);
                this = Point(these_coords);
                this.parents = structure;
                this.mass = A(row, col);
                structure.addPoint(this);
            end
        end
    end
    
    % Connect adjacent points
    for row = 1:height
        above = max(1, row-1);
        below = min(height, row+1);
        for col = 1:length
            if A(row, col)>0
                left = max(1, col-1);
                right = min(length, col+1);
                these_coords = getCoords(row, col, a, height);
                this = structure.getPoint(these_coords);

                % Looks at all adjacent cells in the matrix (incl.
                % diagonals)
                for i = above:below
                    for j = left:right
                        if A(i, j)>0 && ~(i==row && j==col) %second point exists and isn't the same as first point
                            those_coords = getCoords(i,j,a,height);
                            that = structure.getPoint(those_coords);
                            if isempty(this.connected(that))
                                new_link = this.connectTo(that);
                                structure.links = [structure.links new_link];
                            end
                        end
                    end
                end
            end                         
                        
        end
    end
            
%     structure.plotStructure();
end