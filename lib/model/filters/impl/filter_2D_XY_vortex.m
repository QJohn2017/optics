classdef filter_2D_XY_vortex < filter_base
    properties (Access = protected)
        degree
    end
    
    methods
        function obj = filter_2D_XY_vortex(deg)
           obj = obj@filter_base();
           obj.name = 'vortex';
           obj.description = ['degree = ' num2str(deg)];
           obj.degree = deg;
        end
        
        function deg = getDegree(obj)
            deg = obj.degree;
        end
    end
    
    methods (Access = protected)
        function res = applyInternal(obj, beam)
            res = beam_base(beam.getFunction*function_2D_XY_vortex(obj.degree), beam.getField);
        end
    end
end

