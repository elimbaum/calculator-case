include <definitions.scad>;

for (p = [0:NUM_PLUGS-1]) {
    translate([(1.5 * p) * PLUG_DIAM, 0, 0])
    resize([PLUG_DIAM + PLUG_ADJ, PLUG_DIAM - PLUG_ADJ, 0])
    cylinder(r=1, h=PCB_DIM.z + CASE_THICKNESS + SOLDER_LEAD_DIM.z - TOL);
}