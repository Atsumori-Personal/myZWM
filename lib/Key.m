classdef Key
    properties
        height
        width
        data
    end
    methods
        function obj = Key(x)
            sz = size(x);
            obj.height = sz(1);
            obj.width = sz(2);
            obj.data = x;
        end
    end
end