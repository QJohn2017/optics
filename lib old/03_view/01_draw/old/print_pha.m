function print_pha( beam , file_name, title_name, colormap_name )

    if nargin < 4
        colormap_name = 'yarg';
    end

    if length(beam) == 1
        if nargin < 3
            title_name = beam.name;
        end
        if nargin < 2
            file_name = 'Phase';
        end
        
        figure = show_pha(beam, title_name, colormap_name);
        print(figure, [file_name], '-dpng');
    else
        if nargin < 3
            for i=1:length(beam)
                title_name{i} = beam(i).name;
            end
        end
        if nargin < 2
            for i=1:length(beam)
                file_name{i} = ['Phase_' num2str(i)];
            end
        end

        for i = 1:length(beam)
            figure = show_pha(beam(i), title_name{i}, colormap_name);
            print(figure, [file_name{i}], '-dpng');
        end
    end
    
end