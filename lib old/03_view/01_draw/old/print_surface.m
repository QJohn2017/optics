function print_surface( surface_datas, percent_values, percent_transp, file_name, title_name )
    
    if nargin < 3
        if nargin < 2
            percent_values = [0.2 0.4 0.6 0.8];
        end
        percent_transp = ones(1,length(percent_values))/length(percent_values);
    end

    if length(surface_datas) == 1
        if nargin < 5
            title_name = surface_datas.name;
        end
        if nargin < 4
            file_name = 'Surface_0';
        end
        
        figure = show_surface(surface_datas, percent_values, percent_transp, title_name);
        print(figure, [file_name], '-dpng');
    else
        if nargin < 5
            for i = 1:length(surface_datas)
                title_name{i} = surface_datas(i).name;
            end
        end
        if nargin < 4
            for i = 1:length(surface_datas)
                file_name{i} = ['Surface_' num2str(i)];
            end
        end

        for i = 1:length(surface_datas)
            figure = show_surface(surface_datas(i), percent_values, percent_transp, title_name{i});
            print(figure, [file_name{i}], '-dpng');
        end
    end
end