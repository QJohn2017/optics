classdef function_custom < function_base
   
    properties (Access = protected)
        aFunc
    end
    
    methods (Access = public)
        
        function obj = function_custom(aFunc)
            obj = obj@function_base;
            obj.name = 'custom function';
            

            if nargin < 1
                aFunc = @(t) (0);
            end
            
            obj.aFunc = aFunc;
        end

    end
    
    methods (Access = public)

        function value = calculate(obj, point)

            value = obj.aFunc(point);
            
        end
        
        function func = GetFunc(obj)
            func = obj.aFuncl;
        end
        
        function obj = SetFunc(obj, aFunc)
            obj.aFunc = aFunc;
        end
        
    end
end

