classdef function_base < model_base
    
    properties (Access = public)
        func
    end
    
    methods (Access = public)

        function obj = function_base(func)
            if nargin < 1
                func = @(t) 0;
            end
            obj = obj@model_base('default function');
            
            obj.func = func;
        end

    end

    methods (Access = public)

        function value = calculate(obj, params)
            value = obj.func(params);
        end
        
        function values = valuesOnField(obj, field)
            values = 0;
        end
        
        function res = uminus(obj)
            res = obj.*(-1);
        end
        
        function res = plus(left, right)
            res = function_base(@(v) left.func(v)+right.func(v));
        end
        
        function res = minus(left, right)
            res = left+(-right);
        end
        
        function res = times(obj, value)
            res = function_base(@(v) value*obj.func(v));
        end
        
        function res = mtimes(left, right)
            res = function_base(@(v) left.func(v)*right.func(v));
        end
                
        function res = rdivide(obj, value)
            res = obj.*(1/value);
        end
        
        function res = mrdivide(left, right)
            res = function_base(@(v) left.func(v)/right.func(v));
        end

        function res = power(obj, value)
            res = function_base(@(v) obj.func(v)^value);
        end
        
        function res = mpower(left, right)
            res = function_base(@(v) left.func(v)^right.func(v));
        end
    end

end