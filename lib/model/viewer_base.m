classdef viewer_base < model_base

    properties (Access = public)
        colormap_name
    end
    
    methods (Access = public)
        function obj = viewer_base()
            obj = obj@model_base('default viewer');
            
            obj.colormap_name = 'yarg';
        end
        
        function fig = show(obj, model)
            field_root = model.getField;
            axes = field_root.getAxes;
            dim = field_root.getDimension;
            switch dim
                case 1
                    t = axes{1};
                    v = model.getIntensity;
                    fig = plot(t,v);
                case 2
                    x = axes{1};
                    y = axes{2};
                    z = model.getIntensity;
                    %z = model.getPhase;
                    title_name = model.name;
                    axis_labels = field_root.axes_title;

                    fig = obj.show_2D_XY(x,y,z',title_name, axis_labels);
                case 3
                    x = axes{1};
                    y = axes{2};
                    z = axes{3};
                    v = model.getIntensity;
                    title_name = model.name;
                    
                    fig = obj.show_3D_XYZ(x,y,z,v,title_name);
            end
        end
    end
    methods (Access = protected)
        function [ result_figure ] = show_2D_XY(obj, X, Y, Z, title_name, axis_labels, figure_input, axes_input )
            
            local_colormap_name = obj.colormap_name;
            
            if nargin < 6
                axis_labels = {'x, mm' 'y, mm'};
            end
            if nargin < 5
                title_name = '';
            end
            % Create figure
            if strcmp(local_colormap_name, 'yarg')
                step = -1/63;
                colors = (1:step:0)';
                colors_matrix = [colors, colors, colors];
                if nargin < 7
                    result_figure = figure('Colormap', colors_matrix,'name', title_name);
                else
                    result_figure = figure_input;
                    result_figure.Colormap = colors_matrix;
                end
            else
                if nargin < 7
                    result_figure = figure('name', title_name);
                else
                    result_figure = figure_input;
                end
                colormap(local_colormap_name);        
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

        function [ result_figure ] = show_3D_XYZ(obj, x,y,z,v, title_name, percent_values, percent_transp )

            if nargin < 6
                title_name = surface_data.name;
            end
            if nargin < 8
                if nargin < 7
                    percent_values = [0.2 0.4 0.6 0.8];
                end
                percent_transp = ones(1,length(percent_values))/length(percent_values);
            end

            axes_x = x;
            axes_y = y;
            axes_z = z;
            values = v;

            result_figure = figure;
            axesMain = axes('Parent',result_figure);

            %colormap(jet);

            % Create light
            light('Parent',axesMain,...
                'Position',[17.375982876645 -100.556150614945 83.9711431702997],...
                'Style','local');

            % Create zlabel
            zlabel(['z']);

            % Create ylabel
            ylabel(['y']);

            % Create xlabel
            xlabel(['x']);

            % Create title
            title(title_name);

            xlim(axesMain,[min(axes_x) max(axes_x)]);
            ylim(axesMain,[min(axes_y) max(axes_y)]);
            zlim(axesMain,[min(axes_z) max(axes_z)]);

            range_x = max(axes_x)-min(axes_x);
            range_y = max(axes_y)-min(axes_y);
            range_z = max(axes_z)-min(axes_z);
            range_axes = [range_x range_y range_z];
            range_min = min(range_axes);
            range_max = max(range_axes);

            dataAspectRatio = range_axes/range_min;
            n_aspect_ratio_max = 2;
            for i = 1:length(dataAspectRatio)
                if dataAspectRatio(i) > n_aspect_ratio_max
                    dataAspectRatio(i) = dataAspectRatio(i)/n_aspect_ratio_max;
                else
                    dataAspectRatio(i) = 1;
                end
            end

            view(axesMain,[135.00 25.00]);

            box(axesMain,'on');
            grid(axesMain,'on');

            min_value = min(min(min(values)));
            max_value = max(max(max(values)));

            %legend(axesMain,'show');

            % Set the remaining axes properties
            set(axesMain,   'XTick',min(axes_x):(max(axes_x)-min(axes_x))/8:max(axes_x),...
                'YTick',min(axes_y):(max(axes_y)-min(axes_y))/8:max(axes_y),...
                'ZTick',min(axes_z):(max(axes_z)-min(axes_z))/8:max(axes_z),...
                'CLim', [min_value max_value],...
                'DataAspectRatio', dataAspectRatio);


            %colorbar('peer',axesMain,'Limits',[min_value max_value]);

            colors = jet;

            values_byColor = min_value:(max_value-min_value)/(length(colors)-1):max_value;
            values_byPercent = min_value + (max_value-min_value)*percent_values;
            values = permute(values, [2 1 3]);

            for i = 1:length(values_byPercent)
                patched_surface = patch(isosurface(axes_x,axes_y,axes_z,values,values_byPercent(i)));
                isonormals(axes_x,axes_y,axes_z,values,patched_surface);
                patched_surface.FaceAlpha = percent_transp(i);
                diff_val = abs(values_byColor - values_byPercent(i));
                ind = find(diff_val == min(diff_val));
                color = colors(ind(1), :);
                patched_surface.FaceColor = color;
                patched_surface.EdgeColor = 'none';
                patched_surface.DisplayName = ['val = ' num2str(round(values_byPercent(i),3)) ' (' num2str(round(100*percent_values(i),1)) '%)'];
            end

            lighting gouraud

            camlight('headlight');

        end
    end
   
    
end

