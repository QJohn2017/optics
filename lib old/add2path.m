addPath(cd);

function addPath(folderPath)
    
    if nargin < 1
        folderPath = cd;
    end

    if ~contains(path, folderPath)
        addpath(folderPath);
        disp(['Added : ' folderPath]);
    end

    folders = dir(folderPath);

    for i = 1: length(folders)
        folder = folders(i);
        folderName = folder.name;
        if ~contains(folderName, '.')
            addPath([folderPath '\' folderName]);
        end
    end
    
end

