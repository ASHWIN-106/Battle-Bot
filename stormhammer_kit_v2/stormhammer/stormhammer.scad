// STORM HAMMER - 4WD combat robot chassis  (all dimensions mm)
// Auto-generated parametric model. Open in OpenSCAD, press F5 to preview, F6 to render.
// Export: File > Export > STL / or set part= to export one plate flat for DXF.

show_components = true;   // battery, motors, wheels, blade
explode         = 0;      // try 40 for an exploded view

BASE_L=305.0; BASE_W=254.0; BASE_T=3.0;
// Base thinned from 6.0 to 3.0mm for weight saving. Reinforced locally by
// DOUBLER (below) under the bulkhead footprint, where axle/blade loads and
// impact actually transfer into the plate — effectively 6mm in that zone only.
DOUBLER_OUTER=[[145.0,95.0],[305.0,95.0],[305.0,160.0],[145.0,160.0]];
DOUBLER_HOLES=[[160,112.0,5.5],[160,142.0,5.5],[210,112.0,5.5],[210,142.0,5.5],[260,112.0,5.5],[260,142.0,5.5]];
DOUBLER_T=3.0;
SKIRT_T=3.0; SKIRT_H=90.0;
BULK_T=4.0; BULK_X0=145.0; BULK_H=84.0;
AXLE_X=250.0; AXLE_Z=56.0; BLADE_D=125.0; BLADE_Y=127.0;
// PLACEHOLDER — confirm against the real pillow block before cutting bulkheads.
// Compact 20mm-bore pillow blocks are typically 45-60mm bolt spacing;
// a standard industrial UCP204 is 95mm and will NOT fit this 160mm bulkhead.
// Measure your actual bearing's hole-to-hole distance and update this one number.
BEARING_BOLT_SPACING=52.0;
WHEEL_D=80.0; WHEEL_W=25.0; WHEEL_Z=25.0;
NOSE_ANG=32.735; NOSE_LEN=166.433;

module plate(outline, holes, t) {
  difference() {
    linear_extrude(t) polygon(outline);
    for (h = holes) translate([h[0], h[1], -1]) cylinder(d=h[2], h=t+2, $fn=48);
  }
}

BASE_OUTER   = [[15.000,0.000],[305.000,0.000],[305.000,120.000],[185.000,120.000],[185.000,134.000],[305.000,134.000],[305.000,254.000],[15.000,254.000],[0.000,239.000],[0.000,15.000]];
BASE_HOLES   = [[94.5, 16.5, 3.0], [125.5, 16.5, 3.0], [94.5, 56.5, 3.0], [125.5, 56.5, 3.0], [94.5, 197.5, 3.0], [125.5, 197.5, 3.0], [94.5, 237.5, 3.0], [125.5, 237.5, 3.0], [204.5, 16.5, 3.0], [235.5, 16.5, 3.0], [204.5, 56.5, 3.0], [235.5, 56.5, 3.0], [204.5, 197.5, 3.0], [235.5, 197.5, 3.0], [204.5, 237.5, 3.0], [235.5, 237.5, 3.0], [160, 112.0, 5.5], [160, 142.0, 5.5], [210, 112.0, 5.5], [210, 142.0, 5.5], [260, 112.0, 5.5], [260, 142.0, 5.5], [245, 70, 5.5], [285, 70, 5.5], [245, 184, 5.5], [285, 184, 5.5]];
SKIRT_OUTER  = [[0.000,0.000],[305.000,0.000],[165.000,90.000],[40.000,90.000],[0.000,65.000]];
SKIRT_HOLES  = [[110.0, 25.0, 14.0], [220.0, 25.0, 14.0]];
BULK_OUTER   = [[0.000,0.000],[160.000,0.000],[160.000,15.000],[120.000,84.000],[0.000,84.000]];
BULK_HOLES   = [[105.0, 50.0, 20.0], [105.0-BEARING_BOLT_SPACING/2, 50.0, 6.5], [105.0+BEARING_BOLT_SPACING/2, 50.0, 6.5]];
REAR_OUTER   = [[0.000,0.000],[254.000,0.000],[254.000,65.000],[0.000,65.000]];
REAR_HOLES   = [[60.0, 32.5, 12.5], [194.0, 32.5, 12.5]];
FORK_OUTER   = [[225.000,47.500],[325.000,47.500],[345.000,60.000],[345.000,80.000],[325.000,92.500],[225.000,92.500]];
FORK_HOLES   = [[245.0, 70.0, 5.5], [285.0, 70.0, 5.5]];
TOP_OUTER    = [[0.000,0.000],[140.000,0.000],[140.000,118.000],[0.000,118.000]];
TOP_HOLES    = [[12, 12, 4.5], [70, 8, 4.5], [128, 12, 4.5], [12, 106, 4.5], [70, 110, 4.5], [128, 106, 4.5]];
NOSE_OUTER   = [[0.000,0.000],[166.433,0.000],[166.433,118.000],[0.000,118.000]];
NOSE_HOLES   = [[15, 12, 4.5], [15, 106, 4.5], [151.43316977093238, 12, 4.5], [151.43316977093238, 106, 4.5]];

module chassis() {
  color("silver")      plate(BASE_OUTER, BASE_HOLES, BASE_T);                      // base
  color("dimgray")     translate([0,0,-DOUBLER_T-explode]) plate(DOUBLER_OUTER, DOUBLER_HOLES, DOUBLER_T); // bulkhead doubler
  color("darkgreen") {                                                              // skirts
    translate([0, SKIRT_T+explode, 0]) rotate([90,0,0]) plate(SKIRT_OUTER, SKIRT_HOLES, SKIRT_T);
    translate([0, BASE_W+explode, 0])  rotate([90,0,0]) plate(SKIRT_OUTER, SKIRT_HOLES, SKIRT_T);
  }
  color("firebrick") {                                                              // bulkheads
    translate([BULK_X0, 110.0+BULK_T, BASE_T]) rotate([90,0,0]) plate(BULK_OUTER, BULK_HOLES, BULK_T);
    translate([BULK_X0, 140.0+BULK_T, BASE_T]) rotate([90,0,0]) plate(BULK_OUTER, BULK_HOLES, BULK_T);
  }
  color("darkgreen")   translate([-2.0-explode,0,0]) rotate([90,0,90]) plate(REAR_OUTER, REAR_HOLES, 2.0);
  color("dimgray") {                                                                // forks
    translate([0,0,-6.0-explode])     plate(FORK_OUTER, FORK_HOLES, 6.0);
    translate([0,114,-6.0-explode])   plate(FORK_OUTER, FORK_HOLES, 6.0);
  }
  color("green") {                                                                  // top covers
    translate([25.0,0,SKIRT_H-1.5+explode])   plate(TOP_OUTER, TOP_HOLES, 1.5);
    translate([25.0,136,SKIRT_H-1.5+explode]) plate(TOP_OUTER, TOP_HOLES, 1.5);
  }
  color("green") {                                                                  // nose covers
    translate([165.0,0,SKIRT_H+explode])   rotate([0,NOSE_ANG,0]) plate(NOSE_OUTER, NOSE_HOLES, 2.0);
    translate([165.0,136,SKIRT_H+explode]) rotate([0,NOSE_ANG,0]) plate(NOSE_OUTER, NOSE_HOLES, 2.0);
  }
}

module components() {
  color("white")   translate([AXLE_X, BLADE_Y-1, AXLE_Z]) rotate([-90,0,0]) cylinder(d=BLADE_D, h=2, $fn=96);
  color("gray")    translate([AXLE_X, 67, AXLE_Z])        rotate([-90,0,0]) cylinder(d=20, h=120, $fn=32);
  color("black")   for (x=[110.0,220.0]) {
    translate([x, -WHEEL_W, WHEEL_Z])  rotate([-90,0,0]) cylinder(d=WHEEL_D, h=WHEEL_W, $fn=48);
    translate([x, BASE_W, WHEEL_Z])    rotate([-90,0,0]) cylinder(d=WHEEL_D, h=WHEEL_W, $fn=48);
  }
  color("goldenrod") for (x=[110.0,220.0]) {
    translate([x, 5, WHEEL_Z])         rotate([-90,0,0]) cylinder(d=37, h=75, $fn=32);
    translate([x, BASE_W-5, WHEEL_Z])  rotate([90,0,0])  cylinder(d=37, h=75, $fn=32);
  }
  color("navy")    translate([10,51,BASE_T])  cube([94,151,65]);     // 12V 7Ah SLA, laid flat
  color("teal")    translate([106,80,BASE_T]) cube([36,94,45]);      // ESP32 + IBT-2 + buck
  color("purple")  translate([165,5,BASE_T+21]) rotate([-90,0,0]) cylinder(d=42,h=98,$fn=32); // 775 weapon motor
}

chassis();
if (show_components) components();
