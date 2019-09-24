function [ res ] = beam_Circle( resolution, size_beam, radius_circ, center_circ, wavelength )
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        center_circ = [0 0];
    end
    if nargin < 3
        radius_circ = 0.5;
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
    res.name = ['circle'];
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    res.values(resolution(1), resolution(2)) = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            x = res.x(i) - center_circ(1);
            y = res.y(j) - center_circ(2);
            if x^2+y^2<=radius_circ^2
                res.values(i,j) = 1+0j;
            end
        end
    end
end

