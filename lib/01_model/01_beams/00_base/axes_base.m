classdef axes_base
    
    properties (Access = protected)
        grid
        axes
        resolution
        scale
        center
    end
    
    properties (Access = public)
        axes_title
    end
    
    methods (Access = public)
        function obj = axes_base(resolution, scale, center)

            if length(resolution) ~= length(scale)
                error("Length of resolution and scale is not match");
            end
            
            if length(resolution) ~= length(center)
                error("Length of resolution and center is not match");
            end
            
            obj.resolution = resolution;
            obj.scale = scale;
            obj.center = center;
            obj.axes = obj.calculateAxes;
            obj.grid = obj.calculateGrid;
            
        end
        
        function res = getResolution(obj)
            res = obj.resolution;
        end
        
        function sca = getScale(obj)
            sca = obj.scale;
        end
        
        function cen = getCenter(obj)
            cen = obj.center;
        end
        
        function axes = getAxes(obj)
            axes = obj.axes;
        end
        
        function grid = getGrid(obj)
            grid = obj.grid;
        end
        
        function point = getPoint(obj, coord)           
            n = length(coord);
            local_grid = obj.grid;
            for i = 1:n
                local_grid = local_grid{coord(i)};
            end
            point = local_grid;
        end
        
        function obj = setResolution(obj, resolution)
            local_scale = obj.scale;
            local_center = obj.center;
            
            if length(resolution)<length(local_scale)
                obj.scale = local_scale(1:length(resolution));
                warning("Length of new resolution is less then length of scale. Scale was cutted");
            elseif length(resolution)>length(local_scale)
                obj.scale = [local_scale, ones(1,length(resolution)-length(local_scale))];
                warning("Length of new resolution is more then length of scale. Scale was expanded");
            end
            
            if length(resolution)<length(local_center)
                obj.center = local_center(1:length(resolution));
                warning("Length of new resolution is more then length of center. Center was cutted");
            elseif length(resolution)>length(local_center)
                obj.center = [local_center, zeros(1,length(resolution)-length(local_center))];
                warning("Length of new resolution is more then length of center. Center was expanded");
            end

            obj.resolution = resolution;
            obj.axes = obj.calculateAxes;
            obj.grid = obj.calculateGrid;
        end
        
        function obj = setScale(obj, scale)
            local_resolution = obj.resolution;
            
            if length(scale) == 1
                scale = scale * ones(1, lenght(local_resolution));
            end
            
            if length(local_resolution) ~= length(scale)
                error("Length of resolution and scale is not match");
            end
            
            obj.scale = scale;
            obj.axes = obj.calculateAxes;
            obj.grid = obj.calculateGrid;
        end
        
        function obj = setCenter(obj, center)
            local_resolution = obj.resolution;
            
            if length(center) == 1
                center = center * ones(1, lenght(local_resolution));
            end
            
            if length(local_resolution) ~= length(center)
                error("Length of resolution and center is not match");
            end
            
            obj.center = center;
            obj.axes = obj.calculateAxes;
            obj.grid = obj.calculateGrid;
        end
        
        function coord = findPoint(obj, point)
            local_axes = obj.axes;
            
            if length(local_axes) ~= length(point)
                error("Lenght of axes and length of point is not match");
            end
            
            coord(length(local_axes)) = 1;
            for i = 1:length(local_axes)
                axis = local_axes{i};
                axis_ = abs(axis-point(i));
                axis_min = min(axis_);
                indexes = find(axis_ == axis_min);
                coord(i) = indexes(1);
            end
            
        end
       
    end
    
    methods (Access = protected)
        function axes = calculateAxes(obj)
            
            local_resolution = obj.resolution;
            local_scale = obj.scale;
            local_center = obj.center;
            
            axes{length(local_resolution)} = [];
            for i = 1:length(local_resolution)
                start = -0.5*local_scale(i);
                step = local_scale(i)/(local_resolution(i)-1);
                axis = [];
                for j = 1:local_resolution(i)
                    axis(j) = start + (j-1)*step;
                end
                axes{i} = axis + local_center(i);
            end
        end
        
        function grid = calculateGrid(obj)
            local_axes = obj.axes;
            grid = obj.calculateGridPrivate(local_axes);
        end
    end
    
    methods (Access = private)
        function grid = calculateGridPrivate(obj, axes, point)
                        
            if nargin < 3
                point = [];
            end
            
            index = length(point) + 1;
            
            n = length(axes{index});
            
            for i = 1:n
                local_point = [point, axes{index}(i)];
                if index < length(axes)
                    grid{i} = obj.calculateGridPrivate(axes, local_point);
                else
                    grid{i} = local_point;
                end
            end

        end
    end
    
end

