function structure = matrix2beam(A)
    structure = Structure();
    structure.dimensions = 2;
    
    a = 1;
    [height, length] = size(A);
    
    getCoords = @(row, col, a, height) [a*col, a*(height-row+1), 0];
    n = length*height;
    
    for row = 1:height %top to bottom
        for col = 1:length %left to right
            if A(row, col) > 0
                coords = getCoords(row, col, a, height);
                this = Point(coords);
                this.parents = structure;
                this.mass = A(row, col);
            end
            
            structure.addPoint(this);
        end
    end
    

    
    for row = 1:height
        above = max(1, row-1);
        below = min(height, row+1);
        for col = 1:length
            if A(row, col)>0
                coords = getCoords(row, col, a, height);
                this = structure.getPoint(coords);
                left = max(1, col-1);
                right = min(length, col+1);
                for i = above:below
                    for j = left:right
                        if A(i, j)>0
                            that = structure.getPoint( getCoords(i, j, a, height) );
                            new_link = this.connectTo(that);
                            structure.links = [structure.links new_link];
                        end
                    end
                end
            end                         
                        
        end
    end
            
    structure.plotStructure();
            
            
            
%                  n = size(coords, 1);
%             for i = 1:n
%                this = Point(coords(i, :));
%                this.parents = [obj];
%                this.mass = obj.density*obj.volume/n;
%                this.id = i;
%                obj.addPoint(this);
%                for col = 1:i-1
%                    that = obj.points(col);
%                    new_link = this.connectTo(that);
%                    obj.links = [obj.links new_link];
%                end
%             end
end