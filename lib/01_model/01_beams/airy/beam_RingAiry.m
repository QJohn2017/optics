function [ res ] = beam_RingAiry( resolution, size_beam, R, w, center, wavelength )
    if nargin < 6
        wavelength = 0.0005;
    end
    if nargin < 5
        center = [0 0];
    end
    if nargin < 4
        w = 6;
    end
    if nargin < 3
        R = 1;
    end
    if nargin < 2
        size_beam = [5 5];
    end
    if nargin < 1
        resolution = [128 128];
    end
    
    x0 = center(1);
    y0 = center(2);
    
    res.resolution = resolution;
    res.size = size_beam;
    res.wavelength = wavelength;
    res.name = ['ringairy(' num2str(R) ',' num2str(w) ')'];
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;
    
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            x = res.x(i) - x0;
            y = res.y(j) - y0;
            r = sqrt(x^2+y^2);
            res.values(i,j) = real(Ai(w*r, w*R))*Circ(r / (size_beam(1)/2));
        end
    end
    
end

function [ res ] = Circ( r )

    res = 0;
    if abs(r) <= 1
        res = 1;
    end

end

function [ res ] = Ai( x, x0 )
    
    if nargin < 2
        x0 = 0;
    end

    res = 0;
    size = 2*pi;
    dt = 0.05;
    t = -size/2:dt:size/2;
    
    for i = 1:length(t)
        res = res + exp(1j*(((t(i))^3)/3-(x-x0)*t(i)));
        %res = res + cos(((t(i))^3)/3-(-(x-x0)+R)*t(i));
    end

    res = dt * res / pi;
    
end