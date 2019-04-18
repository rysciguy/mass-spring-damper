classdef (Abstract) Gene < handle
    properties
        innovation; %innovation number
        enabled = 1;
    end
    methods (Abstract)
        express(obj, bridge);
    end
end