function result = surface_J_nm( resolution_surface, size_mm, N, M, wavelength_mm )
    
    if nargin < 5
        wavelength_mm = 0.0005; %0.5; mm / mcm
    end
    if nargin < 4
        if nargin < 3
            N = 1;
        end
        M = 0;
    end
    if nargin < 2
        size_mm = 0.002*[1 1 1]; %[2 2 2]; mm / mcm
    end
    if nargin < 1
        resolution_surface = [31 31 31];
    end
    
    result.resolution = resolution_surface;
    result.size = size_mm;
    result.wavelength = wavelength_mm;
    result.name = ['N' num2str(N) ' M' num2str(M)];
    
    dx = result.size(1)/(result.resolution(1)-1);
    dy = result.size(2)/(result.resolution(2)-1);
    dz = result.size(3)/(result.resolution(3)-1);
    result.x = -result.size(1)/2:dx:result.size(1)/2;
    result.y = -result.size(2)/2:dy:result.size(2)/2;
    result.z = -result.size(3)/2:dz:result.size(3)/2;
    
    const_k = 2*pi/wavelength_mm;
    const_dteta = pi/(2*resolution_surface(1)+1);
    
    for i = 1:length(result.x)
        x = result.x(i);
        for j = 1:length(result.y)
            y = result.y(j);
            phi = angle(x + 1j*y);
            for k = 1:length(result.z)
                z = result.z(k);
                r = sqrt(x^2+y^2+z^2);
                teta = angle(z + 1j*sqrt(x^2+y^2));
                function_temp = 0;

                    value_Bessel = function_Bessel(N,const_k*r);
                    value_Legendre = function_Legendre(N,M,teta,phi,const_dteta);
                    function_temp = (1j)^N*value_Bessel*value_Legendre;
                    
                    if abs(function_temp) == inf
                        function_temp = 0;
                        ['"function_temp" is inf!\n']
                    end
                    if isnan(function_temp)
                        function_temp = 0;
                        ['"function_temp" is NaN!\n']
                    end

                result.values(i,j,k) = 4*pi*function_temp*const_k^2;
            end
        end
    end
    
end

function result = W( x, y, z, beam )

    U = beam.x; V = beam.y;
    du = (U(end)-U(1))/(length(U)-1);
    dv = (V(end)-V(1))/(length(V)-1);

    k = 2*pi/beam.wavelength;
    
    result = 0;
    for i=1:length(U)
        u = U(i);
        for j=1:length(V)
            v = V(j);
            result = result + A(u,v,beam)*exp(1j*k*(u*x+v*y))*exp(1j*k*z*sqrt(1-u^2-v^2));
        end
    end
    result = result*du*dv;

end

function result = C ( l, m, beam )

    

end

function result = A_( teta, phi, beam )

    result = A(sin(teta)*cos(phi), sin(teta)*sin(phi), beam);
    
end

function result = A( u, v, beam )

    dx = beam.size(1)/(beam.resolution(1)-1);
    dy = beam.size(2)/(beam.resolution(2)-1);
    k = 2*pi/beam.wavelength;
    
    result = 0;
    for i=1:length(beam.x)
        x = beam.x(i);
        for j=1:length(beam.y)
            y = beam.y(j);
            result = result + beam.function(i,j)*exp(-1j*k*(u*x+v*y));
        end
    end
    result = (-1j/beam.wavelength)*result*dx*dy;
    
end