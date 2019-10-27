classdef function_combo < function_base
    
    properties (Access = public)
        units
    end
    
    methods (Access = public)
        function obj = function_combo(functions)
            if nargin < 1
                units = {};
            end
            
            obj = obj@function_base;
            
            obj.name = 'combo';
            des = '[';
            for i = 1:length(unis)
                unit = units{i};
                des = [des ', '  unit.name];
            end
            des = [des ']'];
            obj.description = des;
            
            obj.units = units;
        end
    end
    
    methods (Access = public)

        function value = calculate(obj, point)

            %

        end

    end
end

