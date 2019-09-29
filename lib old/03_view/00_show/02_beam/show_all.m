function [ result_figure ] = show_all( beams, size_table, type_beams, colormap_names )

    if nargin < 4
        for i = 1:length(beams)
            colormap_names{i} = 'yarg';
        end
    end
    if nargin < 3
        for i = 1:length(beams)
            type_beams{i} = 'int';
        end
    end
    if nargin < 2
        for i = 1
        end
        size_table = [ceil(length(beams)/2) 2];
    end
    
    if ~iscell(colormap_names)
        temp_colormap = colormap_names;
        colormap_names = {};
        for i = 1:length(beams)
            colormap_names{i} = temp_colormap;
        end
    end
    if ~iscell(type_beams)
        temp_type = type_beams;
        type_beams = {};
        for i = 1:length(beams)
            type_beams{i} = temp_type;
        end
    end
    
    result_figure = figure;
    for i = 1:size_table(1)
        for j = 1:size_table(2)
            k = size_table(2)*(i-1)+j;
            if k <= length(beams)
                beam = beams(k);
                type_beam = type_beams{k};
                colormap_name = colormap_names{k};
                X = beam.x;
                Y = beam.y;
                
                if strcmp(type_beam,'int')
                    Z = get_Intensity(beam)';
                end
                if strcmp(type_beam,'pha')
                    Z = get_Phase(beam)';
                end
                if strcmp(type_beam,'mag')
                    Z = get_Magnitude(beam)';
                end
                if strcmp(type_beam,'gpha')
                    Z = abs(get_Phase(beam)');
                end
                
                axes_main = subplot(size_table(1),size_table(2),k);
                show_main(X, Y, Z, [type_beam ' - ' beam.name], colormap_name, 'mm', result_figure, axes_main);
            end
        end
    end
    
    result_figure.Position = result_figure.Position.* [1 1 size_table(2)/2 size_table(1)/2];
    
    %result_figure.Position = [600 100 300*size_table(2) 300*size_table(1)];
end

