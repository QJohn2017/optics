classdef beam_base

    properties (Access = protected, Constant)
        axes_default = {-0.5:0.05:0.5 -0.5:0.05:0.5};
        function_default = function_base
    end

    properties (Access = protected)
        function_root
        axes
        values
    end
    
    methods (Access = public)

        function obj = beam_base(function_root, axes)

            if nargin < 1
                function_root = obj.function_default;
            end

            if nargin < 2
                axes = obj.axes_default;
            end
            
            s(length(axes)) = 0;
            for i = 1:length(axes)
                s(i) = length(axes{i});
            end
            
            obj.axes = axes;
            obj.function_root = function_root;
            values_new = obj.CalculateValues;
            obj = obj.SetValues(values_new);

        end
        
        function fun = GetFunction(obj)
            fun = obj.function_root;
        end

        function obj = SetFunction(obj, function_new)
            obj.function_root = function_new;
            values_new = obj.CalculateValues;
            obj = obj.SetValues(values_new);
        end

        function values = GetValues(obj)
            values = obj.values;
        end

        function axes = GetAxes(obj)
            axes = obj.axes;
        end
        
        function obj = SetAxes(obj, axes)
            obj.axes = {[]};
            obj.axes = axes;
            values_new = obj.CalculateValues;
            obj = obj.SetValues(values_new);
        end
    end

    methods (Access = protected)

        function values = CalculateValues(obj)
           
            local_axes = obj.axes;
            local_function = obj.function_root;
            
            s(length(local_axes)) = 0;
            for i = 1:length(local_axes)
                s(i) = length(local_axes{i});
            end
            
            if length(s) ~= 1
                values = zeros(s);
            else
                values = zeros(1, s);
            end

            count = prod(s);

            coord = ones(1, length(s));
            point = zeros(1, length(s));
            for id_coord_curr = 1:count
                
                for i = 1:length(coord)
                    axis = local_axes{i};
                    point(i) = axis(coord(i));
                end

                value = local_function.Calculate(point);

                values(id_coord_curr) = value;

                for i = 1:length(coord)
                    if coord(i) < s(i)
                        coord(i) = coord(i) + 1;
                        break;
                    else
                        coord(i) = 1;
                        if i ~= length(coord)
                            coord(i+1) = coord(i+1) + 1;
                            break;
                        end
                    end
                end

            end

        end
                
    end

    methods (Access = private)

        function obj = SetValues(obj, values)
            obj.values = [];
            obj.values = values;
        end

    end

end