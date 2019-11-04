classdef filter_base < model_base
    
    methods (Access = public)
        function obj = filter_base()
            obj = obj@model_base('filter', 'empty filter');
        end
    end
    
    methods (Access = public)
        
        function res = apply(obj, beam)
            res = obj.applyInternal(beam);
        end
        
    end

    
    methods (Access = protected)
        
        function res = applyInternal(obj, beam)
            res = beam;
        end
        
    end
end

