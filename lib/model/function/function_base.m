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
        
        function values = getValuesOn(obj, field)
            res = field.getResolution;
            axes = field.getAxes;
            count = prod(res);

            coord = ones(1, length(res));
            point = zeros(1, length(res));
            for id_coord_curr = 1:count
                
                for i = 1:length(coord)
                    axis = axes{i};
                    point(i) = axis(coord(i));
                end

                value = obj.calculate(point);

                values(id_coord_curr) = value;
                
                if id_coord_curr ~= count
                    coord = obj.getNextCoord(res, coord);
                end
            end

            if length(res) > 1
                values = reshape(values, res);
            end
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
    
        methods (Access = private)
        function coordRes = getNextCoord(obj, resolution, coord)
            coord(1) = coord(1) + 1;
            coordRes = obj.getNormCoord(resolution, coord);
        end
        
        function coordNorm = getNormCoord(obj, resolution, coord)
            [isGood, indexBad] = obj.isGoodCoord(resolution, coord);
            if isGood
                coordNorm = coord;
            else
                coord(indexBad) = 1;
                if length(coord) > indexBad
                    coord(indexBad+1) = coord(indexBad+1) + 1;
                end
                if length(coord) == indexBad
                    error("THE END");
                end
                coordNorm = obj.getNormCoord(resolution, coord);
            end
        end
        
        function [isGood, indexBad] = isGoodCoord(obj, resolution, coord)
            isGood = true;
            for indexBad = 1:length(resolution)
                if coord(indexBad) > resolution(indexBad)
                    isGood = false;
                    break;
                end
            end
        end
    end

end