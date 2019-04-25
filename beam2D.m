function structure = beam2D(length, height, varargin)
% Creates a 2-dimensional beam structure given a length, height, and
% optional 'unit' argument

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

    for x = 1:length
        for y = 1:height
            origin = [(x-1)*a, (y-1)*a, 0];
            pix = Pixel(varargin{:}, 'origin', origin, 'unit', a, 'dimensions', dimensions);
            if x == 1
                top = pix.getPoint(origin + [-a/2, a/2, 0]);
                bottom = pix.getPoint(origin + [-a/2, -a/2, 0]);
                top.DOF = [0, 0, 0];
                bottom.DOF = [0, 0, 0];
            end
            structure.incorporate( pix );     
        end
    end
end