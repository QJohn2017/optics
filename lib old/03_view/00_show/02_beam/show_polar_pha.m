function [ result_figure ] = show_polar_pha( beam_polar )
    Y = round(beam_polar.phi/2/pi*360,1);
    X = beam_polar.r;
    Z = angle(beam_polar.values');
    result_figure = show_main(X,Y,Z,beam_polar.name,'yarg',{'r, mm' 'phi, degree'});
end