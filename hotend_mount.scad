include <configuration.scad>;
include <hotend_mount_config.scad>;
//translate([-35.1,-12.6,-7]) import("new_stl/j-head_retainer.STL", convexity=3);

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
  AT = adapter_thickness+2;
  difference(){
    translate([0, mount_radius-2, 0]) cube([40, AT, mount_thickness],center=true);
    translate([16,mount_radius-2, 0]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=AT, center=true);
    #translate([-16,mount_radius-2, 0]) rotate([90,90,0])  cylinder(r=m3_wide_radius, h=AT, center=true);
    pocket();
    mirror([1,0,0]) pocket();
  };
//};
}
module pocket() {
    translate([16,mount_radius-2.6, 0.2]) rotate([90,90,0])  cube([5.8, 6, 2.8],center=true);;
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
mirror([1, 0, 0]) component_cooler_fan_mount();

