function [ result_figure ] = show_oam(oams, type_line, title_name)
    if nargin < 3
        title_name = '';
    end

    if nargin < 2
        type_line = 'line';
    end
    
    % Create figure
    x = oams(1).m;
    if strcmp(type_line,'stairs')
        x = [x (x(end)+1)];
    end
    Y = [];
    [N, M] = size(oams);
    for i = 1:N
        for j = 1:M
            y = abs(oams(i,j).b).^2;
            if strcmp(type_line,'stairs')
                Y = [Y [y y(end)]'];
            else
                Y = [Y y'];
            end
        end
    end
    
    Y = [Y max(max(Y))/2*ones(length(x),1)]; %<--
    
    result_figure = figure;

    % Create axes
    axes_main = axes('Parent',result_figure);
    hold(axes_main,'on');

    % Create stairs
    if strcmp(type_line,'stairs')
        stairs(x,Y,'DisplayName','y','MarkerFaceColor',[0 0 1],...
            'MarkerEdgeColor',[1 0 0],...
            'MarkerSize',10,...
            'LineWidth',1.5);
    end

    if strcmp(type_line,'line')
        plot(x,Y,'DisplayName','y','MarkerFaceColor',[0 0 1],...
            'MarkerEdgeColor',[1 0 0],...
            'MarkerSize',10,...
            'LineWidth',1.5,...
            'LineStyle','--');
    end
    
    if strcmp(type_line,'bar')
        bar(x,Y);
    end
    
    box(axes_main,'on');
    % Set the remaining axes properties
    % Create xlabel
    

    % Create ylabel

    xlabel('m');
    xlim(axes_main,[x(1) x(end)]);
    ylabel('|b_m|^2');
    ylim_max = 1.05*max(max(Y));
    if ylim_max == 0 
        ylim_max = 1;
    end
    ylim(axes_main,[0 ylim_max]);
    
    title(title_name);
    
    set(axes_main,'XGrid','on','XTick',x,'YGrid','on');
    
    length_max_for_legend = 20;
    for i = 1:N
        for j = 1:M
            current_name = oams(i,j).name;
            if length(current_name) > length_max_for_legend
                current_name = [current_name(1:(length_max_for_legend-3)) '...'];
            end
            legend_names{M*(i-1)+j} = current_name;
        end
    end
    legend_main = legend(axes_main, legend_names);
    set(legend_main,'Orientation','vertical','Location','eastoutside');
    result_figure.Position = result_figure.Position .* [1 1 1.25 1];
end