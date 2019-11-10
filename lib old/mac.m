cl

param_beam_res = [64 64];
param_beam_size = [10 10];
param_beam_sigma = 1.2;
param_beam_n = [3];

%param_sys_code = str2num(dec2bin(1942)')'; % SSAU was founded in 1942
param_sys_code = [[0 0 0 1] [1 0 0 1] 0 [0 1 1 0] [0 0 0 1]]; % 1(10) = 0001(2); 9(10) = 1001(2); 4(10) = 0100(2); 2(10) = 0010(2);
%param_sys_code = [str2num(dec2bin(randi(10)-1,4)')' str2num(dec2bin(randi(10)-1,4)')' 0 str2num(dec2bin(randi(10)-1,4)')' str2num(dec2bin(randi(10)-1,4)')']; % случайное число
%param_sys_code = [1 1 1 1 1 1 1 1 1 1 1]; % full 11
%param_sys_code = [1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1]; % full 17
%param_sys_code = [param_sys_code 0 zeros(size(param_sys_code))]; % left orientation
%param_sys_code = [zeros(size(param_sys_code)) 0 param_sys_code]; % right orientation

if (length(param_sys_code)/2-fix(length(param_sys_code)/2)) == 0
    param_sys_code = [0 param_sys_code];
end

param_sys_p = fix(length(param_sys_code)/2);
param_sys_res = param_beam_res;
param_sys_size = param_beam_size;

param_sys_noise_step = 0.25;
param_sys_noise_min = 0.0;%param_sys_noise_step;
param_sys_noise_max = 1.0;
param_sys_noises = param_sys_noise_min:param_sys_noise_step:param_sys_noise_max;

param_sys_z_step = 0;
param_sys_z_min = 1000;%param_sys_z_step;
param_sys_z_max = 5000;
param_sys_z = param_sys_z_min:param_sys_z_step:param_sys_z_max;

text_n = '';
for iter_n = 1:length(param_beam_n)  % start iter_n
    
    for m = -param_sys_p:param_sys_p
        beam_temp = beam_LG(param_beam_res,param_beam_size, param_beam_n(iter_n), m, param_beam_sigma);
        %n = fix(sqrt(prod(param_beam_res))/2) + 1;
        %beam_temp = convert(lg(param_beam_n(iter_n), m, param_beam_size(1)/2, param_beam_sigma, [n 4*n]));
        param_beam_core(m+param_sys_p+1) = beam_temp;
    end
    beam_cores(iter_n) = convert_Beams2Beam(param_beam_core, param_sys_code);
    core_beam = beam_cores(iter_n);
    core_beam.name = ['n=' num2str(param_beam_n(iter_n)) ' - core'];

    oam_cores(iter_n) = oam(core_beam,-param_sys_p:param_sys_p);
    
    info_cores_FM(iter_n) = ~sum(abs(param_sys_code-get_Code(abs(oam_cores(iter_n).b).^2)));
    
    draw(show_info(core_beam), [core_beam.name ' - beam']);
    draw(show_oam(oam_cores(iter_n)), [core_beam.name ' - oams']);
    
    str_fm = ['[-]'];
    if info_cores_FM(iter_n)
        str_fm = ['[+]'];
    end
    str_n = ['n=' num2str(param_beam_n(iter_n))];
    str_line = [str_fm ' ' str_n '\n'];
    text_n = [text_n str_line '\n'];
    
    text_noise{iter_n} = '';
    
    for iter_noise = 1:length(param_sys_noises) % start iter_noise

        beam_inputs(iter_n, iter_noise) = core_beam;
        if param_sys_noises(iter_noise) ~= 0
            beam_inputs(iter_n, iter_noise) = filter_noise_normal(core_beam, param_sys_noises(iter_noise)); beam_inputs(iter_n, iter_noise) = filter_smooth(beam_inputs(iter_n, iter_noise));        
        end
        input_beam = beam_inputs(iter_n, iter_noise);
        input_beam.name = ['n=' num2str(param_beam_n(iter_n)) ' - noise=' strrep(num2str(param_sys_noises(iter_noise)),'.',',') ' - input'];
        
        oam_inputs(iter_n, iter_noise) = oam(input_beam,-param_sys_p:param_sys_p);
        
        draw(show_info(input_beam), [input_beam.name ' - beam']);
        draw(show_oam(oam_inputs(iter_n, iter_noise)), [input_beam.name ' - oams']);
        
        b_core = abs(oam_cores(iter_n).b).^2;
        b_input = abs(oam_inputs(iter_n, iter_noise).b).^2;
        info_inputs_SD(iter_n, iter_noise) = stat_SD(b_core, b_input);
        info_inputs_R(iter_n, iter_noise) = stat_R(b_core, b_input);
        info_inputs_FM(iter_n, iter_noise) = ~sum(abs(param_sys_code-get_Code(b_input)));
        
        str_fm = ['[-]'];
        if info_inputs_FM(iter_n, iter_noise)
            str_fm = ['[+]'];
        end
        str_noise = ['noise: ' strrep(num2str(param_sys_noises(iter_noise)),'.',',')];
        str_sd = ['SD: ' strrep(num2str(info_inputs_SD(iter_n, iter_noise)),'.',',')];
        str_r = [' R:' strrep(num2str(info_inputs_R(iter_n, iter_noise)),'.',',')];
        str_line = [str_fm ' ' str_noise '\t' str_sd '\t' str_r];
        text_noise{iter_n} = [text_noise{iter_n} str_line '\n'];
        
        text_z{iter_n, iter_noise} = '';
        
        for iter_z = 1:length(param_sys_z) % start iter_z
            
            beam_outputs(iter_n, iter_noise, iter_z) = input_beam;
            if param_sys_z(iter_z) ~= 0
                beam_outputs(iter_n, iter_noise, iter_z) = set_Energy(propagator_Frenel(input_beam, param_sys_z(iter_z), param_sys_res, param_sys_size), input_beam);
            end
            output_beam = beam_outputs(iter_n, iter_noise, iter_z);
            output_beam.name = ['n=' num2str(param_beam_n(iter_n)) ' - noise=' strrep(num2str(param_sys_noises(iter_noise)), '.', ',') ' - z=' num2str(param_sys_z(iter_z)) ' - output'];
            
            oam_outputs(iter_n, iter_noise, iter_z) = oam(output_beam,-param_sys_p:param_sys_p);

            draw(show_info(output_beam), [output_beam.name ' - beam']);
            draw(show_oam(oam_outputs(iter_n, iter_noise, iter_z)), [output_beam.name ' - oams']);
            
            b_output = abs(oam_outputs(iter_n, iter_noise, iter_z).b).^2;
            info_outputs_SD(iter_n, iter_noise, iter_z) = stat_SD(b_core, b_output);
            info_outputs_R(iter_n, iter_noise, iter_z) = stat_R(b_core, b_output);
            info_outputs_FM(iter_n, iter_noise, iter_z) = ~sum(abs(param_sys_code-get_Code(b_output)));
            
            str_fm = ['[-]'];
            if info_outputs_FM(iter_n, iter_noise, iter_z)
                str_fm = ['[+]'];
            end
            str_z = [' z: ' num2str(param_sys_z(iter_z))];
            str_sd = ['SD: ' strrep(num2str(info_outputs_SD(iter_n, iter_noise, iter_z)),'.',',')];
            str_r = [' R: ' strrep(num2str(info_outputs_R(iter_n, iter_noise, iter_z)),'.',',')];
            str_line = [str_fm ' ' str_z '\t' str_sd '\t' str_r];
            text_z{iter_n, iter_noise} = [text_z{iter_n, iter_noise} str_line '\n'];
        end % end iter_z
        
        if length(param_sys_z)>1
            sd_output = info_outputs_SD(iter_n, iter_noise, :);
            r_output = info_outputs_R(iter_n, iter_noise, :);

            draw(show_graph(param_sys_z, sd_output(:), input_beam.name, 'SD', 'z, mm'), [input_beam.name ' - SD']);
            draw(show_graph(param_sys_z, r_output(:), input_beam.name, 'R', 'z, mm'), [input_beam.name ' - R']);
        end

    end % end iter_noise
    
    if length(param_sys_noises)>1
        sd_input = info_inputs_SD(iter_n, :);
        r_input = info_inputs_R(iter_n, :);

        draw(show_graph(param_sys_noises, sd_input(:), core_beam.name, 'SD', 'noise'), [core_beam.name ' - SD']);
        draw(show_graph(param_sys_noises, r_input(:), core_beam.name, 'R', 'noise'), [core_beam.name ' - R']);
    end

end % end iter_n

info_text= [date '\n'];
info_text = [info_text 'resolution: ' num2str(param_beam_res) '\n'];
info_text = [info_text 'size: ' num2str(param_beam_size) '\n'];
info_text = [info_text 'sigma: ' strrep(num2str(param_beam_sigma),'.',',') '\n'];
info_text = [info_text 'word: [' num2str(param_sys_code) ']\n\n'];

if exist('text_n') && ~isempty(text_n)
    info_text = [info_text text_n '\n'];
end

if exist('text_noise') && ~isempty(text_noise) && ~isempty(param_sys_noises)
    n = length(text_noise);
    for iter_n = 1:n
        info_text = [info_text ' n: ' num2str(param_beam_n(iter_n)) '\n'];
        info_text = [info_text text_noise{iter_n} '\n'];
    end
end

if exist('text_z') && ~isempty(text_z) && ~isempty(param_sys_z)
    [n m] = size(text_z);
    for iter_n = 1:n
        info_text = [info_text ' n: ' num2str(param_beam_n(iter_n)) '\n'];
        for iter_noise = 1:m
            info_text = [info_text 'noise: ' strrep(num2str(param_sys_noises(iter_noise)),'.',',') '\n'];
            info_text = [info_text text_z{iter_n,iter_noise} '\n'];
        end
    end
end

save_txt(info_text, 'result');

clearvars -except -regexp ^param ^beam ^info ^oam