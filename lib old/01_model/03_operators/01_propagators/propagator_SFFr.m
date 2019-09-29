function [ result ] = propagator_SFFr( beam, way, values, fixed, resolution, size )
    if nargin < 6
        size = beam.size;
    end
    if nargin < 5
        resolution = beam.resolution;
    end
    if nargin < 4
        fixed = [1 0];
    end
    if nargin < 3
        values = [0 0];
    end
    if nargin < 2
        way = [0 1000];
    end
    
    distance = way(2)-way(1);
    
    focus = 1000;
    
    if fixed(1)
        absResolution = [fix(resolution(2)*distance/focus); resolution(2)];
        result = AbsFF(beam, values(1), way, absResolution, size);
    else
        if fixed(2)
            ordResolution = [resolution(1); fix(resolution(1)*distance/focus)];
            result = OrdFF(beam, values(2), way, ordResolution, size);
        end
    end
    
   result.name = ['[' beam.name ']->sffr(' num2str(way(1)) ', ' num2str(way(2)) ')'];
end
function [ res ] = OrdFF( beam, fixed_value, way, resolution, size )
    res.resolution = resolution;
    res.size = size;
    res.wavelength = beam.wavelength;
    k = 2*pi/beam.wavelength;
    step(1) = size(1)/(resolution(1)-1);
    step(2) = (way(2)-way(1))/(resolution(2)-1);
    res.x = (-size(1)/2):step(1):(size(1)/2);
    res.y = way(1):step(2):way(2);
    for ii=1:beam.resolution(2)
        X2(ii,:)=beam.x.^2;
    end
    for jj=1:beam.resolution(1)
        Y2(:,jj)=beam.y'.^2;
    end
    for i = 1:resolution(1)
        for j = 1:resolution(2)         
            x = res.x(i)*beam.x; y = fixed_value*beam.y';
            for ii=1:beam.resolution(2)
                X(ii,:)=x;
            end
            for jj=1:beam.resolution(1)
                Y(:,jj)=y;
            end
            if res.y(j) ~= 0
                E = exp(1i * k * ( (X2+Y2) - 2*(X+Y) ) / (2 * res.y(j)));
                value = 0;
                for ii = 1:beam.resolution(1)
                    value = value + beam.values(ii,:) * E(:,ii);
                end
                e = exp(1i * k * (res.x(i)^2+fixed_value^2)/(2 * res.y(j)));
                res.values(i,j) = e * value / res.y(j);
            else
                res.values(i,j) = beam.values(i,Find(beam.y, fixed_value));
            end
        end
    end
    res.values = -1i * k * res.values / (2 * pi);
end
function [ res ] = AbsFF( beam, fixed_value, way, resolution, size )
    res.resolution = resolution;
    res.size = size;
    res.wavelength = beam.wavelength;
    k = 2*pi/beam.wavelength;
    step(1) = (way(2)-way(1))/(resolution(1)-1);
    step(2) = size(2)/(resolution(2)-1);  
    res.x = way(1):step(1):way(2);
    res.y = (-size(2)/2):step(2):(size(2)/2);
    for ii=1:beam.resolution(2)
        X2(ii,:)=beam.x.^2;
    end
    for jj=1:beam.resolution(1)
        Y2(:,jj)=beam.y'.^2;
    end
    for i = 1:resolution(1)
        for j = 1:resolution(2)         
            x = fixed_value*beam.x; y = res.y(j)*beam.y';
            for ii=1:beam.resolution(2)
                X(ii,:)=x;
            end
            for jj=1:beam.resolution(1)
                Y(:,jj)=y;
            end
            if res.x(i) ~= 0
                E = exp(1i * k * ( (X2+Y2) - 2*(X+Y) ) / (2 * res.x(i)));
                value = 0;
                for ii = 1:beam.resolution(1)
                    value = value + beam.values(ii,:) * E(:,ii);
                end
                e = exp(1i * k * (fixed_value^2+res.y(j)^2)/(2 * res.x(i)));
                res.values(i,j) = e * value / res.x(i);
            else
                res.values(i,j) = beam.values(Find(beam.x, fixed_value), j);
            end
        end
    end
    res.values = -1i * k * res.values / (2 * pi);
end
function [ res ] = Find( array, value )
    res = find(abs(array-value) == min(abs(array-value)));
    res = res(1);
end