classdef (Abstract) Gene < handle
    properties
        innovation; %innovation number
        enabled = 1;
        genotype;
    end
    methods (Abstract)
        express(obj, bridge);
    end
end