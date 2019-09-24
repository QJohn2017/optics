function [ result ] = propagator_SFF( beam, focus, countFocuses, values, fixed )
    if nargin < 5
        fixed = [1; 0];
    end
    if nargin < 4
        values = [0; 0];
    end
    if nargin < 3
        countFocuses = 4;
    end
    if nargin < 2
        focus = 4000;
    end
    if countFocuses > 0 && countFocuses <= 4
        N = countFocuses;
    else
        N = 4;
    end
    period = 4 * focus;
    for i = 1:N
        if i == 1
            beams(i) = operator_FF(beam, period, (4-0.5)*focus);
        else
            beams(i) = operator_FF(beam, period, (i-1.5)*focus);
        end
        localWay = [0.5, 1.5]*focus;
        res(i) = operator_SectionFractionalFourier(beams(i), fixed, values, period, localWay);
    end
    result = res(1);  
    for i = 2:N
        result.values = [result.values; res(i).values];
    end  
    [n, m] = size(result.values);
    if fixed(1)==1
        step = N*focus/(n-1);
        result.x = 0:step:(N*focus);
    end
    if fixed(2)==1
        step = N*focus/(m-1);
        result.y = 0:step:(N*focus);
    end
    result.resolution = [n, m];
    result.way = [0, N*focus];
    if fixed(1) == 1
        index = Find(beam.x, values(1));
        normingValue = max(max(abs(beam.values(index,:))));
        firstMax = max(max(abs(result.values(1,:))));
    else
        index = Find(beam.y, values(2));
        normingValue = max(max(abs(beam.values(:,index))));
        firstMax = max(max(abs(result.values(:,1))));
    end
    result.values = normingValue*(result.values/firstMax);
end

function [ res ] = Find( array, value )
    res = find(abs(array-value) == min(abs(array-value)));
end