add2path

cl

prm_rs = [127 127 127];
prm_sz = [0.004 0.004 0.004];

if ~exist('prm_m')
    prm_m = 1;
end

if ~exist('prm_ns')
    prm_ns = [1 5];
end

clear surfs

for i = 1:length(prm_ns)
    prm_n = prm_ns(i);
    
    s = surface_J_nm(prm_rs, prm_sz, prm_n, prm_m);
    surfs(i) = s;
end

clear prm_n s

surf_root = convert_Surfaces2Surface(surfs);

draw( show_surface(surf_root), 'surf_root' );

slice_x = convert_Surface2Beam(surf_root, 'x');
slice_y = convert_Surface2Beam(surf_root, 'y');
slice_z = convert_Surface2Beam(surf_root, 'z');

draw( show(slice_x, slice_x.name, 'jet'), 'x = 0' );
draw( show(slice_y, slice_y.name, 'jet'), 'y = 0' );
draw( show(slice_z, slice_z.name, 'jet'), 'z = 0' );

