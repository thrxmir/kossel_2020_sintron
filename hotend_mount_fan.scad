include <configuration.scad>;
include <hotend_mount_config.scad>;
//include <hotend_mount.scad>;
//translate([-35.1,-12.6,-7]) import("new_stl/j-head_retainer.STL", convexity=3);


$fn = 60;
AT = adapter_thickness;
BT = 0.6; // bottom thickness 
FS = 40;  // fan size
MR = mount_radius;
WL = 28; //wall len
WT = 1.2; // wall thickness
module hotend_fan_walls() {
//rotate([0,0,293]){ // for align with j-head_retainer.stl
  difference(){
    union() {
      translate([0, MR, -FS/2]) cube([FS, AT, FS],center=true);
        
      difference() {
          translate([0, 0, -(FS-BT/2)]) cube([FS, MR*2, BT],center=true);
          wall_diff();
          mirror([1, 0, 0]) translate([-5.6, 0, 0]) wall(10,30);
      }
      wall(WT,WL);
      mirror([1, 0, 0]) wall(WT,WL);
    //  translate([0, -12, -(FS-BT/2)]) cylinder(r=13,h=BT,center=true);
    }
    translate([0, -12, -(FS-BT/2)]) cylinder(r=12,h=BT,center=true);
    translate([0, -((FS/2-MR)+AT/2), -mount_thickness/2]) cube([FS+2, FS, mount_thickness+0.4],center=true);
    translate([16,mount_radius, -mount_thickness/2]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=adapter_thickness, center=true);
    translate([-16,mount_radius, -mount_thickness/2]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=adapter_thickness, center=true);
    translate([0,mount_radius, -FS/2]) rotate([90,90,0])  cylinder(r=19, h=adapter_thickness, center=true);
  };
//};
}

module wall_diff() {
  translate([-5.6, 0, 0]) wall(10,30);  
}

module wall(wall_size,wall_angel) {
  translate([64.3, FS/2, -FS/2]) rotate([0,0,180])
        rotate_extrude(angle=wall_angel,convexity = 10) translate([84, 0, 0]) square([wall_size,FS],center=true);
}




//hotend_mount_base();
//hotend_cooler_fan_mount();
//component_cooler_fan_mount();
//rotate([0,0,180]) 
//component_cooler_fan_mount();
hotend_fan_walls();

