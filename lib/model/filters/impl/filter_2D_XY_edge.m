classdef filter_2D_XY_edge < filter_base
   
    methods
        function obj = filter_2D_XY_edge()
           obj = obj@filter_base();
           obj.name = 'edge';
        end
        
        function deg = getDegree(obj)
            deg = obj.degree;
        end
    end
    
    methods (Access = protected)
        function res = applyInternal(obj, beam)
            vals = beam.getValues;
            vals = obj.edge(vals);
            func = function_values(vals, beam.getField);
            res = beam_base(func, beam.getField);
        end
        
        function res = edge(obj, values)

            [n, m] = size(values);
            
            for i = 1:n
                for j = 1:m
                    if i == 1
                        res(i,j) = values(i,j);
                    elseif j == 1
                        res(i,j) = values(i,j);
                    elseif i == n
                        res(i,j) = values(i,j);
                    elseif j == m
                        res(i,j) = values(i,j);
                    else
                        sq = values(i-1:i+1,j-1:j+1);
                        val = abs(max(max(sq))-min(min(sq)));
                        res(i,j) = val;
                    end
                end
            end

        end
    end
end

