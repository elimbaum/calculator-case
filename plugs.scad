include <definitions.scad>;

for (p = [0:NUM_PLUGS-1]) {
    translate([(3 * p) * plug_rad, 0, 0])
//    scale([1, 1.05, 1])
    cylinder(r=plug_rad, h=PCB_DIM.z + CASE_THICKNESS);
}