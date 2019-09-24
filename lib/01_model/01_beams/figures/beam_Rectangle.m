function [ result ] = beam_Rectangle( resolution, size_beam, size_rect, center_rect, wavelength )
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        center_rect = [0 0];
    end
    if nargin < 3
        size_rect = [1 1];
    end
    if nargin < 2
        size_beam = [2 2];
    end
    if nargin < 1
        resolution = [127 127];
    end
    rect = @(x,y) function_Rectangle(x-center_rect(1),size_rect(1))*function_Rectangle(y-center_rect(2),size_rect(2));
    result = convert_Func2Beam(rect, resolution, size_beam, 'rectangle', wavelength);
end