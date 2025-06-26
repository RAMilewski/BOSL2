include <BOSL2/std.scad>

$fn = 36;
s_hook(sides = 6);

// Module: s_hook()
// Synopsis: Creates an S-hook
// SynTags: Geom
// Topics: Shapes (3D), Hooks, VNF Generators
// See Also: d_ring()
// Usage: As Module
//   s_hook(or, sides, ....);
// Description:
//   Creates an S-hook with specified cross-section shape and size.
// Arguments:
//   or = the outside radius of the cross-section shape. Default: 0. (circular cross section)
//   sides = the number of sides of the cross-section shape, values less than 3 result in a circular cross-section.
//   l_shaft = length of the shaft, the straight section that passes through the origin. Default: 25.
//   r_loop1 = radius of the loop at the +Y end of the hook. Default: 5
//   angle1 = end angle in degrees of loop1.  Default: 180
//   l_stem1 = length of the straight segment at the end of loop1.
//   r_curl1 = radius of the curl at the +Y end of the hook.  Default: 0 
//   angle_curl1 = end angle in degrees of the curl at the +Y end of the hook. Default: 0
//   r_loop2 = radius of the loop at the -Y end of the hook. 
//   angle2 = end angle in degrees of loop2. Default: 180
//   l_stem2 = length of the straight segment at the end of loop2.





module s_hook(or = 2, sides = 5, l_shaft = 30, 
    r_loop1 = 5, angle1 = 180, l_stem1 = 0, r_curl1 = 0,  angle_curl1 = 10,
    r_loop2 = 5, angle2 = 180, l_stem2 = 0, r_curl2 = 0,  angle_curl2 = 0) {
    
    assert(l_shaft>0,  "l_shaft must be > 0");
    assert(is_int(sides), "Number of sides must be an integer.");

    stem1 = l_stem1 <= 0 ? 1e-10 : l_stem1;
    stem2 = l_stem2 <= 0 ? 1e-10 : l_stem2;

    shape = sides > 2 ? regular_ngon(sides, or, align_side = FWD) : circle(or);     

    path1 = turtle(["setdir", 90, "ymove",l_shaft/2, "arcleft",r_loop1,angle1, "move",stem1, "arcright",r_curl1,angle_curl1]);
    path_sweep(shape,path1);
    path2 = turtle(["setdir", -90, "ymove",-l_shaft/2, "arcleft",r_loop2,angle2, "move",stem2, "arcright",r_curl2,angle_curl2]);
    path_sweep(shape,path2);
  
    endcap = right_half(shape);
    move(path1[len(path1)-1]) rotate_sweep(endcap);
    move(path2[len(path2)-1]) rotate_sweep(endcap);

}
/* */