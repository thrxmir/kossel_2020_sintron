include <configuration.scad>;

adapter_thickness = 4;

$fn = 60;

BOSS=6;  //Base section rounded ends
X=17; //Base section X
Y=8;  //Base section Y
OFF=18;  //Distance between mounting holes
ML=17; //Mount length
MT=2.8; //Mount thickness
MR=3; //Mount radius

module bl_touch_mount(){
    rotate([0, 90, 0]) {
        difference() {
            mount_plate(adapter_thickness);
            translate([-(BOSS/2),-OFF/2,0]) cylinder(r=m3_wide_radius,h=adapter_thickness);
            translate([-(BOSS/2),OFF/2,0]) cylinder(r=m3_wide_radius,h=adapter_thickness);
            #translate([-(BOSS/2),0,0])  cylinder(r=m3_wide_radius,h=adapter_thickness);
        }
        #difference(){
            hull() {
                translate([(X/2)-MR,MT/2,MR]) rotate([90, 0, 0])  cylinder(r=MR,h=MT);
                translate([(X/2)-MR,MT/2,ML]) rotate([90, 0, 0])  cylinder(r=MR,h=MT);
            }
            translate([(X/2)-MR, MT/2, ML])  rotate([90, 0, 0]) cylinder(r=m3_wide_radius,h=MT);
        }
        difference(){
            len=Y+3;
            translate([0,0,-38])mount_plate(38);
            translate([-0.8,0,-38])mount_plate(38);
            translate([-2,-thickness/2,-(len)]) cube([X,thickness,len]);
        }
        
    }
}

module mount_plate(thickness) {
    hull() {
        offset=2;
        translate([-(BOSS/2),-OFF/2,0]) cylinder(r=BOSS,h=thickness);
        translate([-(BOSS/2),OFF/2,0]) cylinder(r=BOSS,h=thickness);
        translate([-(X/2+offset),-Y/2,0]) cube([X+offset,Y,thickness]);
    }
}


bl_touch_mount();