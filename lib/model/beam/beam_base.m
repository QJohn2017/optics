classdef beam_base < model_base

    properties (Access = protected)
        function_root
        axes_root
        values
    end
    
    methods (Access = public)

        function obj = beam_base(function_root, axes_root)
            
            if nargin < 1
                function_root = function_base;
            end

            if nargin < 2
                axes_root = axes_base;
            end
            
            obj = obj@model_base([function_root.name ' _ ' axes_root.name]);

            obj.axes_root = axes_root;
            obj.function_root = function_root;
            values_new = obj.calculateValues;
            obj = obj.setValues(values_new);

        end
        
        function fun = getFunction(obj)
            fun = obj.function_root;
        end

        function obj = setFunction(obj, function_new)
            obj.function_root = function_new;
            values_new = obj.calculateValues;
            obj = obj.setValues(values_new);
        end

        function values = getValues(obj)
            values = obj.values;
        end

        function axes = getAxes(obj)
            axes = obj.axes_root;
        end
        
        function obj = setAxes(obj, axes)
            obj.axes_root = axes;
            values_new = obj.calculateValues;
            obj = obj.setValues(values_new);
        end
    end

    methods (Access = protected)

        function values = calculateValues(obj, local_function, local_axes)
            
            if nargin < 2
                local_function = obj.function_root;
            end
            
            if nargin < 3
                local_axes = obj.axes_root;
            end
            
            res = local_axes.getResolution;
            
            count = prod(res);

            coord = ones(1, length(res));
            point = zeros(1, length(res));
            for id_coord_curr = 1:count
                
                for i = 1:length(coord)
                    axis = local_axes.getAxes{i};
                    i;
                    coord;
                    point(i) = axis(coord(i));
                end

                value = local_function.calculate(point);

                values(id_coord_curr) = value;
                
                if id_coord_curr ~= count
                    coord = obj.getNextCoord(res, coord);
                end
            end

            if length(res) > 1
                values = reshape(values, res);
            end
            
        end
                
    end

    methods (Access = private)

        function obj = setValues(obj, values)
            obj.values = [];
            obj.values = values;
        end
        
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