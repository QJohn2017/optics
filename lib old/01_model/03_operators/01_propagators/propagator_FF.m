function [ result ] = propagator_FF( beam, distance, period, resolution, size )
% It returns fractional Fourier of beam with period along distance

    if nargin < 5
        size = beam.size;
    end
    if nargin < 4
        resolution = beam.resolution;
    end
    if nargin < 3
        period = 4000;
    end
    if nargin < 2
        distance = 1000;
    end
    
    focus = period / 4;
    
    if 0 <= distance && distance < focus/2
        beam_help = propagator_FF(beam, period, 3*focus, resolution, size);
        new_distance = distance+focus;
        result = propagator_FF(beam_help, period, new_distance, resolution, size);
    else
         if focus*7/2 < distance && distance <= 4*focus
            beam_help = propagator_FF(beam, period, 3*focus, resolution, size);
            new_distance = distance-3*focus;
            result = propagator_FF(beam_help, period, new_distance, resolution, size);
         else
             if focus*3/2 < distance && distance < focus*5/2
                beam_help = propagator_FF(beam, period, focus, resolution, size);
                new_distance = distance-focus;
                result = propagator_FF(beam_help, period, new_distance, resolution, size);
             else
                result.resolution = resolution;
                result.size = size;
                result.wavelength = beam.wavelength;
                k = 2*pi/beam.wavelength;
                dx = size(1)/(resolution(1)-1);
                dy = size(2)/(resolution(2)-1);
                result.x = (-size(1)/2):dx:(size(1)/2);
                result.y = (-size(2)/2):dy:(size(2)/2);
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
                        E = exp(1i * k * ( A(distance, period)*(X2+Y2) - 2*(X+Y) ) / (2 * B(distance, period)));
                        value = 0;
                        for ii = 1:beam.resolution(1)
                            value = value + beam.values(ii,:) * E(:,ii);
                        end
                        e = exp(1i *k * D(distance, period) * (result.x(i)^2+result.y(j)^2)/(2 * B(distance, period)));
                        result.values(i,j) = e * value * dx * dy;
                    end
                end
                result.values = -1i * k * result.values / (2 * pi * B(distance, period));
                result = set_Energy(result, beam);
            end  
        end       
    end
    
    result.name = ['[' beam.name ']->FF(' num2str(distance) '/' num2str(period) ')'];
     
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