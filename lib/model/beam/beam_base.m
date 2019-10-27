classdef beam_base < model_base

    properties (Access = protected)
        function_root
        field_root
        values
    end
    
    methods (Access = public)

        function obj = beam_base(function_root, field_root)
            
            if nargin < 1
                function_root = function_base;
            end

            if nargin < 2
                field_root = field_base;
            end
            
            obj = obj@model_base([function_root.name ' _ ' field_root.name]);

            obj.field_root = field_root;
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

        function field = getField(obj)
            field = obj.field_root;
        end
        
        function obj = setField(obj, field)
            obj.field_root = field;
            values_new = obj.calculateValues;
            obj = obj.setValues(values_new);
        end
        
        function resultBeam = plus(obj, beam)
            
            local_field = obj.getField;
            beam_field = beam.getField;
            
            [res, mes] = local_field.checkEquals(beam_field);
            
            if ~res
                error(mes);
            end
            
            local_dim = local_field.getDimension;
            local_res = local_field.getResolution;
            local_sca = local_field.getScale;
            local_cen = local_field.getCenter;
            
            local_values = obj.getValues;
            beam_values = beam.getValues;
            
            field = field_ND_base(local_dim, local_res, local_sca, local_cen);
            fu = function_custom(local_values + beam_values, field);
            
            resultBeam = beam_base(fu, field);
            
        end
        
        function resultBeam = minus(obj, beam)
            local_field = obj.getField;
            beam_field = beam.getField;
            
            [res, mes] = local_field.checkEquals(beam_field);
            
            if ~res
                error(mes);
            end
            
            local_dim = local_field.getDimension;
            local_res = local_field.getResolution;
            local_sca = local_field.getScale;
            local_cen = local_field.getCenter;
            
            local_values = obj.getValues;
            beam_values = beam.getValues;
            
            field = field_ND_base(local_dim, local_res, local_sca, local_cen);
            fu = function_custom(local_values - beam_values, field);
            
            resultBeam = beam_base(fu, field);
        end
        
        function mag = getMagnitude(obj)
            mag = abs(obj.values);
        end
        
        function int = getIntensity(obj)
            int = obj.getMagnitude^2;
        end
        
        function res = getMaxMag(obj, matrix)
            if nargin < 2
                res = obj.getMaxMag(getMagnitude);
            else
                
                if length(matrix) > 1
                    res = obj.getMaxMag(max(matrix));
                else
                    res = matrix;
                end
            end
        end
        
        function res = getMaxInt(obj)
            res = obj.getMaxMag^2;
        end
        
        function res = getPhase(obj)
            res = angle(obj.values);
        end
        
        function res = getGradientPhase(obj)
            res = abs(obj.getPhase);
        end
        
    end

    methods (Access = protected)

        function values = calculateValues(obj, local_function, local_field)

            if nargin < 2
                local_function = obj.function_root;
            end
            
            if nargin < 3
                local_field = obj.field_root;
            end
            
            res = local_field.getResolution;
            
            count = prod(res);

            coord = ones(1, length(res));
            point = zeros(1, length(res));
            for id_coord_curr = 1:count
                
                for i = 1:length(coord)
                    axis = local_field.getAxes{i};
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