include <configuration.scad>;
//translate([-35.1,-12.6,-7]) import("new_stl/j-head_retainer.STL", convexity=3);

// Overall mount dimensions
mount_radius = 18;
mount_thickness = 6;

adapter_thickness = 4;
// Through holes
hole_radius = 12.5;

// Slot and lip for installation
slot_radius = 6;
lip_radius = 8.1;
lip_thickness = 1;

$fn = 60;

module hotend_mount_base() {
    difference() {
      cylinder(r=mount_radius, h=mount_thickness, center=true);

      // Thru holes
      for (hole_angle = [0:60:360]) {
        translate([sin(hole_angle)*hole_radius,cos(hole_angle)*hole_radius,0]) cylinder(r=m3_wide_radius, h=mount_thickness, center=true);
      }

      // Thru slot
      cylinder(r=slot_radius, h=mount_thickness, center=true);
      translate([0, -(mount_radius/2 + 2), 0]) cube([2*slot_radius-0.8, mount_radius, mount_thickness], center=true);

      // Lip 
      translate([0, 0, (mount_thickness-lip_thickness)/2]) cylinder(r=lip_radius, h=lip_thickness, center=true);
      translate([0, -mount_radius/2, (mount_thickness-lip_thickness)/2]) cube([2*lip_radius, mount_radius, lip_thickness], center=true);

      // Cut off the sharp edges at the front
      translate([0, -7/4*mount_radius, 0]) cube([2*mount_radius, 2*mount_radius, mount_thickness], center=true);
    };
}


module hotend_cooler_fan_mount() {
//rotate([0,0,293]){ // for align with j-head_retainer.stl
  difference(){
    translate([0, mount_radius, 0]) cube([mount_radius*2.2, adapter_thickness, mount_thickness],center=true);
    translate([16,mount_radius, 0]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=adapter_thickness, center=true);
    translate([-16,mount_radius, 0]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=adapter_thickness, center=true);
  };
//};
}

module component_cooler_fan_mount() {
  translate([-(mount_radius+2), 0, 0]) {
    difference(){
      translate([0, adapter_thickness/2+1.5, 0]) cube([12,adapter_thickness,mount_thickness],center=true);
      translate([-3,adapter_thickness/2+1.5, 0]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=adapter_thickness, center=true);
    };
    difference(){
      translate([0, -(adapter_thickness/2+1.5), 0]) cube([12,adapter_thickness,mount_thickness],center=true);
      translate([-3,-(adapter_thickness/2+1.5), 0]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=adapter_thickness, center=true);
    };
  };
}


hotend_mount_base();
hotend_cooler_fan_mount();
component_cooler_fan_mount();
rotate([0,0,180])
component_cooler_fan_mount();
