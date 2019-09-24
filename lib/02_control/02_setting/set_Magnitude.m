function [ res ] = operator_SetMagnitude( beam_to, beam_from )
% It sets absolute values of beamFrom to beamTo

    res = beam_to;
    p = get_Magnitude(beam_from);
    r = get_Magnitude(beam_to);
    res.values = res.values.*(p./r);

end

