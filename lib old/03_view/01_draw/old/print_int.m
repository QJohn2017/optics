function print_int( beam , file_name, title_name, colormap_name )

    if nargin < 4
        colormap_name = 'yarg';
    end

    if length(beam) == 1
        if nargin < 3
            title_name = beam.name;
        end
        if nargin < 2
            file_name = 'Intensity';
        end
        
        figure = show_int(beam, title_name, colormap_name);
        print(figure, [file_name], '-dpng');
    else
        if nargin < 3
            for i=1:length(beam)
                title_name{i} = beam(i).name;
            end
        end
        if nargin < 2
            for i=1:length(beam)
                file_name{i} = ['Intensity_' num2str(i)];
            end
        end

        for i = 1:length(beam)
            figure = show_int(beam(i), title_name{i}, colormap_name);
            print(figure, [file_name{i}], '-dpng');
        end
    end
end