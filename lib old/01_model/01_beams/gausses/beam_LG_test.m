function [ res ] = beam_LG_test( resolution, size_beam, N, M, sigma, wavelength )
    if nargin < 6
        wavelength = 0.0005;
    end
    if nargin < 5
        sigma = 0.25;
    end
    if nargin < 3
        N = 3;
        M = 0;
    end
    if nargin < 2
        size_beam = [2 2];
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
    eNorm = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            r = sqrt(res.x(i)^2+res.y(j)^2);
            phi = angle(res.x(i)+1j*res.y(j));
            
            w0 = sigma;
            z = 0;
            
            L_ = function_Laguerre(N, abs(M), 2*(r/w(z, w0, wavelength))^2);
            A1 = -(r/w(z, w0, wavelength))^2;
            A2 = 1j*(2*pi/wavelength)*r/(2*R(z, w0, wavelength));
            A_ = exp(A1+A2);
            G_ = w0/w(z, w0, wavelength)*(2/w(z, w0, wavelength))^abs(M);
            E_ = exp(-1j*(N+2*M+1)*ee(z, w0, wavelength));
            R_ = r^abs(M)*exp(1j*M*phi);
            
            value = L_*A_*G_*E_*R_;
            res.values(i,j) = value;
            
            eNorm = eNorm + abs(value)^2;
        end
    end
    eNorm = 1;%eNorm*(dx*dy);

    res.values = res.values / sqrt(get_Energy(res));
end

function [ result ] = zr( w0, wave )
    result = pi*w0^2/wave;
end

function [ result ] = w( z, w0, wave )
    result = w0*sqrt(1+(z/zr(w0, wave))^2);
end

function [ result ] = R( z, w0, wave )
    if z == 0 
        result = inf;
        return;
    end
    result = z*(1+(zr(w0, wave)/z)^2);
end

function [ result ] = ee( z, w0, wave )
    result = angle(zr(w0, wave)+1j*z);
end