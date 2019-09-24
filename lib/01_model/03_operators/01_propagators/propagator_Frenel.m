function [ result ] = propagator_Frenel( beam, distance, resolution, size )
% It returns Frenel of beam

    if nargin < 4
        size = beam.size;
    end
    if nargin < 3
        resolution = beam.resolution;
    end
    if nargin < 2
        distance = 1000;
    end
    result.resolution = resolution;
    result.size = size;
    result.wavelength = beam.wavelength; 
    k = 2*pi/beam.wavelength;
    dx = size(1)/(resolution(1)-1);
    dy = size(2)/(resolution(2)-1);
    result.x = (-size(1)/2):dx:(size(1)/2);
    result.y = (-size(2)/2):dy:(size(2)/2);
    for i=1:beam.resolution(2)
        X2(i,:)=beam.x.^2;
    end
    for j=1:beam.resolution(1)
        Y2(:,j)=beam.y'.^2;
    end
    for i = 1:resolution(1)
        u_i = result.x(i);
        x_i = u_i * beam.x;
        for j = 1:resolution(2)
            v_j = result.y(j);
            y_j = v_j * beam.y';
            for ii=1:beam.resolution(2)
                X_i(ii,:)=x_i;
            end
            for jj=1:beam.resolution(1)
                Y_j(:,jj)=y_j;
            end
            E = exp(1i * k * ( (X2 + Y2) - 2*(X_i + Y_j) ) / (2 * distance));
            value = 0;
            for t = 1:beam.resolution(1)
                value = value + beam.values(t,:) * E(:,t);
            end
            e = exp(1i * k * (result.x(i)^2+result.y(j)^2)/(2 * distance));
            result.values(i,j) = e * value * dx * dy;
        end
    end
    result.values = -1i * k * exp(1j * k * distance) * result.values / (2 * pi * distance);
    result.name = ['[' beam.name ']->Fr(' num2str(distance) ')'];
    
end