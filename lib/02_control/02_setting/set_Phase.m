function [ res ] = operator_SetPhase( beam_to, beam_from )
% It sets angle values of beamFrom to beamTo

    res = beam_to;
    psi = get_Phase(beam_from);
    phi = get_Phase(beam_to);
    res.values = res.values.*exp(1j*(psi-phi));

end

