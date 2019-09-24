function [ result ] = propagator_Fourier( beam, focus, resolution, size )
% It returns Fourier of beam

    if nargin < 4
        size = beam.size;
    end
    if nargin < 3
        resolution = beam.resolution;
    end
    if nargin < 2
        focus = 1000;
    end
    result.resolution = resolution;
    result.size = size;
    result.wavelength = beam.wavelength;
    result.name = ['fourier(' beam.name ')'];
    
    k = 2*pi/beam.wavelength;
    
    step(1) = size(1)/(resolution(1)-1);
    step(2) = size(2)/(resolution(2)-1);
        
    result.x = (-size(1)/2):step(1):(size(1)/2);
    result.y = (-size(2)/2):step(2):(size(2)/2);

    for ii=1:beam.resolution(2)
        X2(ii,:)=beam.x.^2;
    end
    for jj=1:beam.resolution(1)
        Y2(:,jj)=beam.y'.^2;
    end
    
    for i = 1:resolution(1)
        for j = 1:resolution(2)         
            x = result.x(i)*beam.x; y = result.y(j)*beam.y';
            for ii=1:beam.resolution(2)
                X(ii,:)=x;
            end
            for jj=1:beam.resolution(1)
                Y(:,jj)=y;
            end
            E = exp(1i * k * ( - 2*(X+Y) ) / (2 * focus));
            
            value = 0;
            for ii = 1:beam.resolution(1)
                value = value + beam.values(ii,:) * E(:,ii);
            end
            result.values(i,j) = value;
        end
    end
    
    result.values = -1i * k * result.values / (2 * pi * focus);
    
    result = set_Energy(result, beam);
    
    result.name = ['[' beam.name ']->F(' num2str(focus) ')'];

end