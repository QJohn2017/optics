function [ result_figure ] = show_main( X, Y, Z, title_name, colormap_name, axis_labels, figure_input, axes_input )
% 
    if nargin < 6
        axis_labels = {'x, mm' 'y, mm'};
    end
    if nargin < 5
        colormap_name = 'yarg';
    end
    if nargin < 4
        title_name = '';
    end
    % Create figure
    if strcmp(colormap_name, 'yarg')
        step = -1/63;
        colors = (1:step:0)';
        colors_matrix = [colors, colors, colors];
        if nargin < 7
            result_figure = figure('Colormap', colors_matrix);
        else
            result_figure = figure_input;
            result_figure.Colormap = colors_matrix;
        end
    else
        if nargin < 7
            result_figure = figure;
        else
            result_figure = figure_input;
        end
        colormap(colormap_name);        
    end

    % Create axes
    if nargin < 8
        axesMain = axes('Parent', result_figure);
    else
        axesMain = axes_input;
        axesMain.Parent = result_figure;
    end
    hold(axesMain,'on');

    % Create image
    image(X, Y, Z,'Parent',axesMain,'CDataMapping','scaled');

    % Create xlabel
    xlabel([axis_labels(1)]);
    xlim(axesMain, [min(X), max(X)]);

    % Create ylabel
    ylabel([axis_labels(2)]);
    ylim(axesMain, [min(Y), max(Y)]);

    box(axesMain,'on');
    axis(axesMain,'tight');
    title(title_name);
    
    % Set the remaining axes properties
    set(axesMain,'DataAspectRatio',[1 1 1],'Layer','top',...
        'XTick', min(X):(max(X)-min(X))/8:max(X),...
        'YTick', min(Y):(max(Y)-min(Y))/8:max(Y));

    if (X(length(X))-X(1))~=(Y(length(Y))-Y(1))
        axis('normal');
    end
    
    grid on
    
    colorbar;
end
