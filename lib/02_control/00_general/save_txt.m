function save_txt( str, file_name )
    
    file = fopen([file_name '.txt'],'w');
    fprintf(file,str);
    fclose(file);

end

