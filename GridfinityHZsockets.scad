include <modules/gridfinity_modules.scad>
cylinderHeight = 57;
cup_height = 3;
cylinder_diameter = 21.5;
easement_z = 0.0; // a slightly large opening at the top for compliance while inserting.
minimum_wall = 4;
blocks_needed = ceil((cylinder_diameter+2*minimum_wall)/gridfinity_pitch);

render()
glue_stick_cup(blocks_needed, 2, cup_height);


module glue_stick_cup(num_x=1, num_y=1, num_z=2, bottom_holes=0) {
  difference() {
    grid_block(num_x, num_y, num_z, bottom_holes ? 5 : 0, center=true);
    translate([0,-(cylinderHeight/2)-1,20
      ]) rotate([-90,0,0]) glue_stick(num_z, cylinder_diameter);
  }
}

module glue_stick(num_z=5, diam) {
  floor_thickness = blocks_needed > 1 ? 5.5 : 1.2;
  translate([0, 0, floor_thickness]) cylinder(h=cylinderHeight, d=diam);
  translate([0, 0, (num_z - easement_z)*gridfinity_zpitch + 1.2]) 
    cylinder(h=easement_z*gridfinity_zpitch, d1=diam, d2=diam*1.1);
}
