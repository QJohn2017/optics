function [ result ] = function_Random( resolution )
    if nargin < 1
        resolution = [1 1];
    end
    result = rand(resolution);
end