$fn = 50;

holderX = 120;
holderThickness = 10;
holderZ = 20;

/* Aquaris X */
/* phoneHolderX = 80;
phoneY = 69;
phoneY2 = 78; //with case
phoneZ = 9; */

/* Samsung Galaxy Tab2 */
phoneHolderX = 100;
phoneY = 166;
phoneY2 = 170; //with case
phoneZ = 7;


extensionLen = 150;
extensionY = 50;

phoneHolderWall = 2;

railExtra = 1;
railRad = 2;

railExtr = 100; //fixed extrusion of rails in clamp

module pattern(rad=10,thickness=2, dist=50, heigth=40, cnt=5)
{
  for(obj=[0:cnt-1])
    translate([dist*obj,0,0])
    hull()
    {
      cylinder(r=rad,h=thickness);
      translate([0,heigth-rad*2,0]) cylinder(r=rad,h=thickness);
    }
}

/* pattern(); */
/* phoneY2+phoneHolderWall*2 */
module rail(lenY=50)
{
  cube([holderThickness/2+railExtra,lenY,3]);
  translate([railRad,0,3]) rotate([-90,0,0]) cylinder(r=railRad,h=lenY);
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
    translate([moveRailX-moveRailScale,0,(holderZ)/2])
      resize([0,100,0]) scale([1.05,1,1.05]) rail( phoneY2+phoneHolderWall*2);
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
    difference() {
      rotate([-50,0,0])
      translate([0,0,holderZ/2])
      cube([holderThickness,10,holderZ*4]);
      translate([0,0,-13]) cube([holderThickness,50,holderZ]);
      translate([0,40,-13+holderZ*3]) cube([holderThickness,50,holderZ]);
    }
  }
  translate([holderX-holderThickness,30,13])
  union()
  {
    difference() {
      rotate([-50,0,0])
      translate([0,0,holderZ/2])
      cube([holderThickness,10,holderZ*4]);
      translate([0,0,-13]) cube([holderThickness,50,holderZ]);
      translate([0,40,-13+holderZ*3]) cube([holderThickness,50,holderZ]);
    }
  }
}
/* A(); */

module phoneHolder(patternOn=false)
{
  difference() {
    cube([phoneHolderX,phoneY2+phoneHolderWall*2,phoneZ+phoneHolderWall]);
    translate([phoneHolderWall,phoneHolderWall+(phoneY2-phoneY)/2,phoneHolderWall]) cube([phoneHolderX-phoneHolderWall,phoneY,phoneZ]);

    translate([phoneHolderWall,phoneHolderWall+(phoneY2-phoneY)/2,phoneHolderWall+phoneZ/2]) rotate([0,90,0])
      scale([1.1,0.8,1]) cylinder(r=phoneZ/2,h=phoneHolderX-phoneHolderWall);
    translate([phoneHolderWall,(phoneY2+phoneHolderWall*2)-phoneHolderWall-(phoneY2-phoneY)/2,phoneHolderWall+phoneZ/2]) rotate([0,90,0])
      scale([1.1,0.8,1]) cylinder(r=phoneZ/2,h=phoneHolderX-phoneHolderWall);

    if(patternOn == true)
    {
      translate([25,25,0]) pattern(rad=6,thickness=phoneHolderWall, dist=25, heigth=140, cnt=3);
    }
  }
  translate([-holderThickness/2-railExtra,0,0]) rail( phoneY2+phoneHolderWall*2);
}

module extension(bottom=true)
{
  rail();
  difference()
  {
    union()
    {
      translate([holderThickness/2+railExtra,0,0]) cube([extensionLen,extensionY,11]);
    }
    translate([20,12.5,0]) pattern(rad=8,thickness=11, dist=28, heigth=40, cnt=5);
    if(bottom == true)
    {
      translate([extensionLen,-2,3]) scale([1.05,1,1.05]) rail();
    }else{
      translate([extensionLen,0,3]) scale([1.05,1,1.05]) rail();
    }
  }
}

/* #translate([55,phoneHolderWall,phoneHolderWall]) cube([100,169,5]); */
extension(false);
/* #translate([30,10,0]) pattern(rad=5,thickness=10, dist=25, heigth=40, cnt=5); */
/* rail(); */
/* translate([10.2,10,(holderZ-phoneZ-phoneHolderWall)/2+0.1])  */
/* phoneHolder(); */
/* phoneHolder(patternOn=true); */
/* translate([-holderX,10,0]) CouchPotatoClamp(); */
