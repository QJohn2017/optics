function [ result ] = oam( beams, array_M )

    if nargin < 2
        array_M = -5:1:5;
    end
    [N, M] = size(beams);
    for index_N = 1:N
        for index_M = 1:M
            beam = beams(index_N, index_M);
            result(index_N, index_M).m = array_M;
            dx = beam.size(1)/(beam.resolution(1)-1);
            dy = beam.size(2)/(beam.resolution(2)-1);
            for k = 1:length(result(index_N, index_M).m)
                value = 0;
                for i = 1:length(beam.x)
                    for j = 1:length(beam.y)
                        m = result(index_N, index_M).m(k);
                        phi = angle(beam.x(i)+1j*beam.y(j));
                        value = value + beam.values(i,j)*exp(-1j*m*phi);
                    end
                end
                result(index_N, index_M).b(k) = value;
            end

            result(index_N, index_M).b = result(index_N, index_M).b*dx*dy;

            result(index_N, index_M).J_z = sum(result(index_N, index_M).m.*abs(result(index_N, index_M).b).^2)/sum(abs(result(index_N, index_M).b).^2);

            result(index_N, index_M).name = beam.name;
        end
    end
end