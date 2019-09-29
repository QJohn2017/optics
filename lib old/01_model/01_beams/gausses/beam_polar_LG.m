function [ res ] = beam_polar_LG( resolution, R, N, M, sigma, wavelength )

    if nargin < 6
        wavelength = 0.0005;
    end
    if nargin < 5
        sigma = 1.0;
    end
    if nargin < 4
        M = 1;
    end
    if nargin < 3
        N = 2;
    end
    if nargin < 2
        R = 4;
    end
    if nargin < 1
        resolution = [63 255];
    end

    dr = R/(resolution(1)-1);
    dphi = 2*pi/(resolution(2)-1);

    res.r = 0:dr:R;
    res.phi = 0:dphi:(2*pi);
    res.wavelength = wavelength;
    res.name = ['LG' '(' num2str(N) ',' num2str(M) ')'];

    for i = 1:length(res.r)
        for j = 1:length(res.phi)
            w0 = sigma;

            value = Gnm(res.r(i)/w0, N, M) * exp(1j*M*res.phi(j));

            res.values(i,j) = value;
        end
    end

    res.values = res.values / Enm(dr, R, w0, N, M);
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