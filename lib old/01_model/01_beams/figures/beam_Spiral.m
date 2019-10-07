function [ res ] = beam_Spiral( resolution, size_beam, N, wavelength )

    if nargin < 4
        wavelength = 0.0005;
    end
    if nargin < 3
        N = 1;
    end
    if nargin < 2
        size_beam = [16 16];
    end
    if nargin < 1
        resolution = [128 128];
    end
    res.resolution = resolution;
    res.size = size_beam;
    res.wavelength = wavelength;
    res.name = 'spiral';
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    res.values(resolution(1), resolution(2)) = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            for t = 0:0.05:L(2*pi*N)
                r = sqrt(res.x(i)^2+res.y(j)^2);
                phi = angle(res.x(i)+1j*res.y(j));
                tphi = angle(exp(1j*t));
                dr = abs(r^2 - t^2);
                dphi = abs(phi - tphi);
                if dr <= 0.5^2 && dphi <= 0.05
                    res.values(i,j) = 1+0j;
                end
            end
        end
    end
end

function [ res ] = L(phi)
    res = (phi*sqrt(1+phi^2)+log(phi+sqrt(1+phi^2)) )/2;
end