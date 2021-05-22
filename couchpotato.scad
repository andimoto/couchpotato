$fn = 50;

holderX = 120;
holderThickness = 10;
holderZ = 20;

phoneHolderX = 80;
phoneYDispl = 68;
phoneY2 = 77; //with case
phoneZ = 9;

phoneHolderWall = 2;

railExtra = 1;
railRad = 2;


module rail()
{
  cube([holderThickness/2+railExtra,phoneY2+phoneHolderWall*2,3]);
  translate([railRad,0,3]) rotate([-90,0,0]) cylinder(r=railRad,h=phoneY2+phoneHolderWall*2);
}

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
  difference()
  {
    union()
    {
      cube([holderX,holderThickness,holderZ]);
        U();
      translate([holderX-holderThickness,0,0])
        U();
    }
    moveRailX = holderX-holderThickness/2-railExtra;
    moveRailScale = 0;//(holderThickness/2+railExtra)*0.05;
    translate([moveRailX-moveRailScale,0,(holderZ-phoneZ-phoneHolderWall)/2])
      scale([1.05,1,1.05]) rail();
  }
}


module CouchPotatoClamp()
{
  A();
  translate([0,0,holderZ*3])
    A();
  translate([20,0,holderZ]) cube([20,holderThickness,holderZ*2]);
  translate([holderX-40,0,holderZ]) cube([20,holderThickness,holderZ*2]);

  translate([0,30,13])
  union()
  {
    rotate([-50,0,0])
    translate([0,0,holderZ/2])
    cube([holderThickness,10,holderZ*4]);
  }
  translate([holderX-holderThickness,30,13])
  union()
  {
    rotate([-50,0,0])
    translate([0,0,holderZ/2])
    cube([holderThickness,10,holderZ*4]);
  }
}
/* A(); */

module phoneHolder()
{
  difference() {
    cube([phoneHolderX,phoneY2+phoneHolderWall*2,phoneZ+phoneHolderWall]);
    translate([phoneHolderWall,phoneHolderWall+(phoneY2-phoneYDispl)/2,phoneHolderWall]) cube([phoneHolderX-phoneHolderWall,phoneYDispl,phoneZ]);

    translate([phoneHolderWall,phoneHolderWall+(phoneY2-phoneYDispl)/2,phoneHolderWall+phoneZ/2]) rotate([0,90,0])
      scale([1.1,0.8,1]) cylinder(r=phoneZ/2,h=phoneHolderX-phoneHolderWall);
    translate([phoneHolderWall,(phoneY2+phoneHolderWall*2)-phoneHolderWall-(phoneY2-phoneYDispl)/2,phoneHolderWall+phoneZ/2]) rotate([0,90,0])
      scale([1.1,0.8,1]) cylinder(r=phoneZ/2,h=phoneHolderX-phoneHolderWall);
  }
  translate([-holderThickness/2-railExtra,0,0]) rail();
}
translate([10.2,10,(holderZ-phoneZ-phoneHolderWall)/2+0.1]) phoneHolder();
/* translate([-holderX,10,0]) CouchPotatoClamp(); */
