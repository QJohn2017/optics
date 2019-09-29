function [ res ] = beam_Triangle( resolution, size_beam, size_tri, center_tri, wavelength )
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        center_tri = [0 0];
    end
    if nargin < 3
        size_tri = 0.75;
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
    res.name = 'triangle';
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    y0 = center_tri(2); x0 = center_tri(1);
    res.values(resolution(1), resolution(2)) = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            y = res.y(j)-y0;
            x = res.x(i)-x0;
            first_cond = y>=-sqrt(3)*size_tri/4;
            second_cond = y<=sqrt(3)*(x+size_tri/4);
            third_cond = y<=sqrt(3)*(-x+size_tri/4);
            if first_cond && second_cond && third_cond
                res.values(i,j) = 1+0j;
            end
        end
    end
end