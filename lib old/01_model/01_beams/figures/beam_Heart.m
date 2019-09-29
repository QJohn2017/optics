function [ res ] = beam_Heart( resolution, size_beam, center_heart, radius, wavelength )
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        radius = 0.25;
    end
    if nargin < 3
        center_heart = [0 0];
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
    res.name = 'heart';
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    y0 = center_heart(2); x0 = center_heart(1);
    res.values(resolution(1), resolution(2)) = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            y = res.y(j)-y0;
            x = res.x(i)-x0;
            if (x+radius)^2+(y-radius)^2<=radius^2 || (x-radius)^2+(y-radius)^2<=radius^2
                res.values(i,j) = 1+0j;
            end
            if x^2+(y-radius)^2<=(2*radius)^2 && y <= radius
                res.values(i,j) = 1+0j;
            end
            first_cond = y<=-sqrt(2)*radius+radius;
            second_cond = y>=-x-sqrt(2)*2*radius+radius;
            third_cond = y>=x-sqrt(2)*2*radius+radius;
            if first_cond && second_cond && third_cond
                res.values(i,j) = 1+0j;
            end
        end
    end
end