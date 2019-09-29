classdef function_base
   
    properties (Access = public)
        name
    end
    
    methods (Access = public)

        function obj = function_base(name)
            if nargin < 1
                name = 'default function';
            end
            obj.name = name;
        end

    end

    methods (Access = public)

        function value = calculate(obj, params)
            value = 0;
        end

    end

end