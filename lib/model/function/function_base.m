classdef function_base < model_base
       
    methods (Access = public)

        function obj = function_base()
            obj = obj@model_base('default function');
        end

    end

    methods (Access = public)

        function value = calculate(obj, params)
            if sum(params(1)*ones(size(params)) ~= params)
                value = 0;
            else
                value = 1;
            end
        end
        
        %function value = subsref(obj, params)
        %    value = obj.calculate(params.subs{1});
        %end
        
    end

end