function [ res ] = SectionFractionalFourier( beam, fixed, values, period, way, resolution, size )
    if nargin < 7
        size = beam.size;
    end
    if nargin < 6
        resolution = beam.resolution;
    end
    if nargin < 5
        way = [0;1000];
    end
    if nargin < 4
        period = 4000;
    end
    if nargin < 3
        values = [0; 0];
    end
    if nargin < 2
        fixed = [1; 0];
    end
    distance = way(2)-way(1);
    if fixed(1)
        absResolution = [fix(resolution(2)*4*distance/period); resolution(2)];
        res = AbsFF(beam, values(1), period, way, absResolution, size);
    else
        if fixed(2)
            ordResolution = [resolution(1); fix(resolution(1)*4*distance/period)];
            res = OrdFF(beam, values(2), period, way, ordResolution, size);
        end
    end
end
function [ res ] = OrdFF( beam, fixed_value, period, way, resolution, size )
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
            E = exp(1i * k * ( A(res.y(j), period)*(X2+Y2) - 2*(X+Y) ) / (2 * B(res.y(j), period)));
            value = 0;
            for ii = 1:beam.resolution(1)
                value = value + beam.function(ii,:) * E(:,ii);
            end
            e = exp(1i * k * D(res.y(j), period) * (res.x(i)^2+fixed_value^2)/(2 * B(res.y(j), period)));
            res.function(i,j) = e * value / B(res.y(j), period);
        end
    end
    res.function = -1i * res.k * res.function / (2 * pi);
end

function [ res ] = AbsFF( beam, fixed_value, period, way, resolution, size )
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
            E = exp(1i * k * ( A(res.x(i), period)*(X2+Y2) - 2*(X+Y) ) / (2 * B(res.x(i), period)));
            
            value = 0;
            for ii = 1:beam.resolution(1)
                value = value + beam.function(ii,:) * E(:,ii);
            end
            e = exp(1i * k * D(res.x(i), period) * (fixed_value^2+res.y(j)^2)/(2 * B(res.x(i), period)));
            res.function(i,j) = e * value / B(res.x(i), period);
        end
    end
    res.function = -1i * k * res.function / (2 * pi);
end
function [ res ] = A( distance, period )
    t = 2*pi*distance/period;
    res = cos(t);
end
function [ res ] = B( distance, period )
    t = 2*pi*distance/period;
    res = period * sin(t) / 4;
end
function [ res ] = C( distance, period )
    t = 2*pi*distance/period;
    res = -4 * sin(t) / period;
end
function [ res ] = D( distance, period )
    t = 2*pi*distance/period;
    res = cos(t);
end