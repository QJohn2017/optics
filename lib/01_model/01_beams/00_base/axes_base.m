classdef axes_base
    
    properties (Access = protected)
        grid
        resolution
        scale
    end
    
    methods (Access = public)
        function obj = axes_base(resolution, scale)
            if nargin < 1
                resolution = [31 31];
            end
            
            if nargin < 2
                scale = [1 1];
            end
            
            if length(resolution) ~= length(scale)
                error("Length of resolution and scale is not match");
            end
            
            obj.resolution = resolution;
            obj.scale = scale;
            obj.grid = obj.calculateGrid(resolution, scale);
            
        end
        
        function res = getResolution(obj)
            res = obj.resolution;
        end
        
        function sca = getScale(obj)
            sca = obj.scale;
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
            if length(resolution) ~= length(local_scale)
                error("Length of resolution and scale is not match");
            end
            obj.resolution = resolution;
            obj.grid = obj.calculateGrid(resolution, local_scale);
        end
        
        function obj = setScale(obj, scale)
            local_resolution = obj.resolution;
            if length(local_resolution) ~= length(scale)
                error("Length of resolution and scale is not match");
            end
            obj.scale = scale;
            obj.grid = obj.calculateGrid(local_resolution, scale);
        end
    end
    
    methods (Access = protected)
        function grid = calculateGrid(obj, resolution, scale, point)
            
            if length(resolution) ~= length(scale)
                error("Length of resolution and scale is not match");
            end
            
            if nargin < 4
                point = [];
            end
            
            index = length(point) + 1;
            
            n = resolution(index);
            
            if index < length(resolution)

                for i = 1:n
                    local_point = [point, scale(index)*(-0.5+(i-1)*(1/(resolution(index)-1)))];
                    grid{i} = obj.calculateGrid(resolution, scale, local_point);
                end

            else

                for i = 1:n
                    local_point = [point, scale(index)*(-0.5+(i-1)*(1/(resolution(index)-1)))];
                    grid{i} = local_point;
                end
                
            end
        end
    end
    
end

