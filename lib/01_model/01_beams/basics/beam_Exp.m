function [ result ] = beam_Exp( resolution, size_beam, M, wavelength )
    if nargin < 4
        wavelength = 0.0005;
    end
    if nargin < 3
        M = 1;
    end
    if nargin < 2
        size_beam = [2 2];
    end
    if nargin < 1
        resolution = [128 128];
    end
    result.resolution = resolution;
    result.size = size_beam;
    result.wavelength = wavelength;
    result.name = 'full';
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    result.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    result.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    result.values(resolution(1), resolution(2)) = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            r = sqrt(result.x(i)^2+result.y(j)^2);
            value = 0;
            if r < result.size(1)/2
                phi = angle(result.x(i)+1j*result.y(j));
                value = exp(1j*M*phi);
            end
            result.values(i,j) = value;
        end
    end
    
    %result.values = result.values / sqrt(get_Energy(result));
end