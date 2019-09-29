function [ res ] = beam_Full( resolution, size_beam, wavelength )
    if nargin < 3
        wavelength = 0.0005;
    end
    if nargin < 2
        size_beam = [2 2];
    end
    if nargin < 1
        resolution = [128 128];
    end
    res.resolution = resolution;
    res.size = size_beam;
    res.wavelength = wavelength;
    res.name = 'full';
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    res.values(resolution(1), resolution(2)) = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
                res.values(i,j) = 1;
        end
    end
end