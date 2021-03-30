// units: inch
include <Round-Anything/polyround.scad>;
include <definitions.scad>;

// TODO:
// snaps
// battery molding


module mounting_holes() {
    // two mounting holes @ bottom
    translate([0, HOLE_POS.y + HOLE_RAD, -CASE_THICKNESS-TOL]) {
        hole_x_offset = HOLE_POS.x + HOLE_RAD;
        hole_height = 2*TOL + PCB_DIM.z + CASE_THICKNESS + SOLDER_LEAD_DIM.z;
        translate([hole_x_offset, 0, -SOLDER_LEAD_DIM.z]) {
            cylinder(r=HOLE_RAD, h=hole_height);
        }
        
        translate([PCB_DIM.x - hole_x_offset, 0, -SOLDER_LEAD_DIM.z]) {
            cylinder(r=HOLE_RAD, h=hole_height);
        }
    }  
}

module calculator() {
    // circuit board
    color("green")
    difference() {
        cube(PCB_DIM);
        
        mounting_holes();
        
    }
    
    // display
    color("red")
    translate(
        [(PCB_DIM.x - SCREEN_DIM.x) / 2,
         PCB_DIM.y - SCREEN_DIM.y - SCREEN_OFFSET,
         PCB_DIM.z - TOL])
    {
        cube([0, 0, TOL] + SCREEN_DIM);
    }
    
    // battery
    color("gray")
    translate(
        [PCB_DIM.x - BATT_POS.x - BATT_RAD,
         PCB_DIM.y - BATT_POS.y - BATT_RAD,
         PCB_DIM.z - TOL])
    {
        cylinder(r=BATT_RAD, h=BATT_HEIGHT);
    }
    
    // solder leads
    color("gray")
    translate([
                (PCB_DIM.x - SOLDER_LEAD_DIM.x)/2,
                PCB_DIM.y - SOLDER_LEAD_DIM.y - SCREEN_OFFSET,
                -SOLDER_LEAD_DIM.z]) {
        cube(SOLDER_LEAD_DIM);
    }
    
}

module case() {
    color("yellow", 0.3) {
//        cube([CASE_WIDTH, CASE_BASE_LENGTH, CASE_BASE_HEIGHT]);
//        translate([0, CASE_BASE_LENGTH, 0])
//            cube([CASE_WIDTH, CASE_TOP_LENGTH, CASE_TOP_HEIGHT]);
        
        // case profile
        rotate([90, 0, 90])
            linear_extrude(CASE_WIDTH)
            polygon(polyRound([
                     [0, 0, CASE_ROUND],
                     [FULL_CASE_LENGTH, 0, CASE_ROUND],
                     [FULL_CASE_LENGTH, CASE_TOP_HEIGHT, CASE_ROUND],
                     [FULL_CASE_LENGTH - CASE_TOP_LENGTH,
                        CASE_TOP_HEIGHT, CASE_ROUND],
                     [CASE_BASE_LENGTH, CASE_BASE_HEIGHT, CASE_ROUND],
                     [0, CASE_BASE_HEIGHT, CASE_ROUND]]));
    }
}

module screen_profile(extrude_amt) {
    rotate([90, -90, 180])
    linear_extrude(extrude_amt)
    projection(cut = true)
    rotate([90, 0, 90])
    translate([0, - (PCB_DIM.y - SCREEN_OFFSET - SCREEN_DIM.y/2), 0])
    calculator();
}

module battery_profile(extrude_amt) {
    rotate([90, -90, 180])
    linear_extrude(extrude_amt)
    projection(cut = true)
    rotate([90, 0, 90])
    translate([0, - (PCB_DIM.y - BATT_POS.y - BATT_RAD), 0])
    calculator();
}

module cutout() {
    union() {
        translate([0, -(CASE_THICKNESS+TOL), 0]) {
            screen_profile(PCB_DIM.y - SCREEN_OFFSET);
            battery_profile(PCB_DIM.y - BATT_POS.y + CASE_THICKNESS);
        }
        mounting_holes();
        
        // battery cutout
        translate(
            [PCB_DIM.x - BATT_POS.x - BATT_RAD,
             PCB_DIM.y - BATT_POS.y - BATT_RAD,
             PCB_DIM.z - TOL])
        {
            cylinder(r=BATT_RAD + BATT_CUTOUT_ADJ, h=BATT_HEIGHT);
        }
        
        // full calculator, just to make sure
        calculator();
    }    
}

scale(25.4) {

translate([0, CASE_THICKNESS, CASE_THICKNESS + SOLDER_LEAD_DIM.z]) {
    if ($preview) calculator();

    difference() {
        translate([-CASE_THICKNESS,
                   -CASE_THICKNESS,
                   -CASE_THICKNESS - SOLDER_LEAD_DIM.z])
            case();
           
        cutout();
    }
}

translate([0, -0.25, 0]) {
    include <plugs.scad>;
}
}
//cutout();