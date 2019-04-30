function RGB = strainColor(Strain)
%     load('blueBlackRed.mat');
    color_map = jet;
    Strain = abs(Strain);
    
    strain_range = [0 0.1];
    color_range = 1:size(color_map, 1);
    strain_idxs = round(mapFromTo(Strain, strain_range, color_range));
    RGB = color_map(strain_idxs, :);
end