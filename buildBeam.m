function structure = buildBeam(length, height, width, varargin)
    % Defaults
    a = 1;
    
    % Arguments
    for index = 1:2:size(varargin, 2)
        switch lower(varargin{index}) %key
            case 'unit'
                a = varargin{index+1};
        end
    end

    % Build beam
    structure = Structure();
    
    if width == 0
        dimensions = 2;
    else
        dimensions = 3;
    end

    for x = 1:length
        for y = 1:height
            if dimensions == 2
                origin = [(x-1)*a, (y-1)*a, 0];
                vox = Voxel(varargin{:}, 'origin', origin, 'unit', a, 'dimensions', dimensions);
                structure.incorporate( vox );
                
            elseif dimensions == 3
                for z = 1:width
                    origin = [(x-1)*a, (y-1)*a, (z-1)*a];
                    vox = Voxel(varargin{:}, 'origin', origin, 'unit', a, 'dimensions', dimensions);
                    structure.incorporate( vox );
                end
            end
        end
    end
end