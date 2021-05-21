$fn = 50;

holderX = 160;
holderThickness = 10;
holderZ = 40;


module U()
{
  hull()
  {
    cube([holderThickness,100,holderZ]);
    translate([0,140,holderZ/2]) rotate([0,90,0]) cylinder(r=holderZ/2,h=holderThickness);
  }
}
/* X(); */

module A()
{
  cube([holderX,holderThickness,holderZ]);
    U();
  translate([holderX-holderThickness,0,0])
    U();
}


module CouchPotato()
{
  A();
  translate([0,0,holderZ*2]) A();
  translate([20,0,0]) cube([20,holderThickness,holderZ*2]);
  translate([holderX-40,0,0]) cube([20,holderThickness,holderZ*2]);

  translate([0,0,10])
  union()
  {
    rotate([-50,0,0])
    translate([0,0,holderZ/2])
    cube([holderThickness,20,holderZ*3]);
  }
  translate([holderX-holderThickness,0,10])
  union()
  {
    rotate([-50,0,0])
    translate([0,0,holderZ/2])
    cube([holderThickness,20,holderZ*3]);
  }
}
A();

/* CouchPotato(); */
