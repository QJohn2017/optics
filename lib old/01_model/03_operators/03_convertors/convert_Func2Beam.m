function [ result ] = convert_Func2Beam( func, resolution, size_beam, name, wavelength )
    
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        name = 'unnamed';
    end
    if nargin < 3
        size_beam = [2 2];
    end
    if nargin < 2
        resolution = [127 127];
    end

    dx = size_beam(1)/(resolution(1)-1);
    dy = size_beam(2)/(resolution(2)-1);

    result.x = -size_beam(1)/2:dx:size_beam(1)/2;
    result.y = -size_beam(2)/2:dy:size_beam(2)/2;
    result.wavelength = wavelength;
    result.name = name;
    
    for i = 1:length(result.x)
        x = result.x(i);
        for j = 1:length(result.y)
            y = result.y(j);
            result.values(i,j) = func(x,y);
        end
    end
end