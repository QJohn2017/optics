function [ res ] = beam_LG( resolution, size_beam, N, M, sigma, wavelength )
    if nargin < 6
        wavelength = 0.0005;
    end
    if nargin < 5
        sigma = 1.0;
    end
    if nargin < 3
        M = 1;
    end
    if nargin < 3
        N = 2;
    end
    if nargin < 2
        size_beam = [8 8];
    end
    if nargin < 1
        resolution = [127 127];
    end
    res.resolution = resolution;
    res.size = size_beam;
    res.wavelength = wavelength;
    res.name = ['LG' '(' num2str(N) ',' num2str(M) ')'];
    dx = size_beam(1)/(resolution(1)-1);
    dy = size_beam(2)/(resolution(2)-1); 
    for i = 1:resolution(1)
        res.x(i) = -size_beam(1)/2+dx*(i-1);
    end
    for j = 1:resolution(2)
        res.y(j) = -size_beam(2)/2+dy*(j-1);
    end
    res.values(resolution(1), resolution(2)) = 0;

    for i = 1:resolution(1)
        for j = 1:resolution(2)
            r = sqrt(res.x(i)^2+res.y(j)^2);
            value = 0;
            if r <= res.size(1)/2
                phi = angle(res.x(i)+1j*res.y(j));

                w0 = sigma;

                value = Gnm(r/w0, N, M) * exp(1j*M*phi);
            end
            res.values(i,j) = value;
        end
    end

    res.values = res.values /(Enm(sqrt(dx^2+dy^2), res.size(1)/2, w0, N, M));
end

function [ result ] = Gnm( r, N, M )
    result = function_Laguerre(N, abs(M), 2*(r)^2) * (sqrt(2)*r)^abs(M) * exp(-(r)^2);
end

function [ result ] = Enm( dr, r_max, w0, N, M )

    value = 0;
    for r = 0:dr:r_max
        value = value + r*Gnm(r/w0,N,M);
    end
    result = 2*pi*value*dr;
end