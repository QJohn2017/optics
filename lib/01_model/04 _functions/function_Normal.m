function [ result ] = function_Normal( nu, sigma2, resolution )
    if nargin < 3
        resolution = [1 1];
    end
    if nargin < 2
        sigma2 = 1;
    end
    if nargin < 1
        nu = 0;
    end
    result = sqrt(sigma2).*randn(resolution) + nu;
end